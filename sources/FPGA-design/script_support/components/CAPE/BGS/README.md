完整开发流程指南
总体架构
基于你项目的实际情况，推荐的硬件架构如下：


DDR (CPU写入像素数据)
     │
     ▼
  [PDMA] ──── FIC 接口 ────→ [你的自定义 HDL 模块]
     ▲                            │
     │                    ┌───────┴───────┐
     │                    │  APB 寄存器    │ ← CPU 通过 /dev/mem 或 UIO 访问
     │                    │  (控制+状态)   │
     │                    └───────────────┘
     │
     └──── DDR (结果可选写回)
这个项目没有独立的 Fabric DMA IP，DMA 有两种方式：

PDMA（MSS 内置）：通过 mpfs-dma-proxy 驱动 + udmabuf 从 Linux userspace 使用
自己写 AXI Master：在 FPGA 逻辑中实现 AXI4 master，直接通过 FIC_0/FIC_1 读写 DDR
第一步：编写你的 Verilog 模块
参考 apb_ctrl_status.v 的模式。我以 VERILOG_TEMPLATE 为例讲解，你需要在自己的 CAPE variant 目录下创建类似的文件。

你需要创建 两个 Verilog 文件：

1. 自定义计算模块 (pixel_compute.v)
这是纯计算逻辑 + APB 寄存器接口，参考 apb_ctrl_status.v + servos.v 的混合模式：


`timescale 1ns/100ps
module pixel_compute(
    // APB 接口
    input               pclk,
    input               presetn,
    input               penable,
    input               psel,
    input       [7:0]   paddr,
    input               pwrite,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,

    // 数据流输入 (来自 DMA/FIC)
    input       [23:0]  pixel_data_in,    // 每像素 24bit
    input               pixel_valid,      // 数据有效
    output  reg         pixel_ready,      // 准备好接收

    // 结果输出 (可选写回 DDR)
    output  reg [23:0]  result_out,       // 24bit boolean result
    output  reg         result_valid,

    // 中断
    output  reg         irq
);

    // ==========================================
    // 寄存器地址定义 (8-bit 地址空间)
    // ==========================================
    localparam [7:0] STATUS_REG    = 8'h00;  // RO: 状态 (busy, done, error)
    localparam [7:0] CONTROL_REG   = 8'h10;  // RW: 启动、配置
    localparam [7:0] THRESHOLD_REG = 8'h20;  // RW: 阈值
    localparam [7:0] REF_VALUE_REG = 8'h30;  // RW: 参考值(做差的"特定数")
    localparam [7:0] PIXEL_COUNT   = 8'h40;  // RW: 总像素数
    localparam [7:0] RESULT_REG    = 8'h50;  // RO: 汇总结果 (如超过了阈值的像素数)

    // ==========================================
    // APB 读写逻辑
    // ==========================================
    reg [31:0] control_reg;
    reg [31:0] threshold_reg;
    reg [31:0] ref_value_reg;
    reg [31:0] pixel_count_reg;
    reg [31:0] result_sum;

    wire rd_enable = (!pwrite && psel);
    wire wr_enable = (penable && pwrite && psel);

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            control_reg    <= 32'h00000000;
            threshold_reg  <= 32'h00000000;
            ref_value_reg  <= 32'h00000000;
            pixel_count_reg <= 32'h00000000;
            result_sum     <= 32'h00000000;
            prdata         <= 32'b0;
        end else begin
            // 写操作
            if (wr_enable) begin
                case (paddr[7:0])
                    CONTROL_REG:   control_reg    <= pwdata;
                    THRESHOLD_REG: threshold_reg  <= pwdata;
                    REF_VALUE_REG: ref_value_reg  <= pwdata;
                    PIXEL_COUNT:   pixel_count_reg <= pwdata;
                endcase
            end

            // 读操作
            if (rd_enable) begin
                case (paddr[7:0])
                    STATUS_REG:    prdata <= {31'b0, busy};  // bit0 = busy flag
                    CONTROL_REG:   prdata <= control_reg;
                    THRESHOLD_REG: prdata <= threshold_reg;
                    REF_VALUE_REG: prdata <= ref_value_reg;
                    PIXEL_COUNT:   prdata <= pixel_count_reg;
                    RESULT_REG:    prdata <= result_sum;
                    default:       prdata <= 32'hDEADBEEF;  // debug magic
                endcase
            end
        end
    end

    // ==========================================
    // 计算流水线
    // ==========================================
    reg busy;
    reg [31:0] pixel_counter;
    // ... 你的计算逻辑 ...

    // 状态机: IDLE -> RUNNING -> DONE
    localparam IDLE = 0, RUNNING = 1, DONE = 2;
    reg [1:0] state;

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            state         <= IDLE;
            busy          <= 1'b0;
            pixel_counter <= 0;
            result_sum    <= 0;
            irq           <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    irq <= 1'b0;
                    if (control_reg[0]) begin  // start bit
                        state <= RUNNING;
                        busy  <= 1'b1;
                        pixel_counter <= 0;
                        result_sum <= 0;
                    end
                end

                RUNNING: begin
                    pixel_ready <= 1'b1;
                    if (pixel_valid && pixel_ready) begin
                        // === 你的计算逻辑 ===
                        // 对每个像素的24组数据做差后累加
                        // if (|pixel_data_in - ref_value| + acc > threshold)
                        //    result_sum <= result_sum + 1;
                        // ===================

                        pixel_counter <= pixel_counter + 1;
                        if (pixel_counter == pixel_count_reg - 1) begin
                            state <= DONE;
                            busy  <= 1'b0;
                            irq   <= 1'b1;   // 触发中断通知 CPU
                        end
                    end
                end

                DONE: begin
                    if (control_reg[0] == 1'b0) begin  // CPU 清除 start bit
                        state <= IDLE;
                        irq   <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
第二步：修改 TCL 文件
假设你基于 VERILOG_TEMPLATE 创建自己的 variant（比如叫 PIXEL_PROC），需要修改两个 TCL 文件。

2.1 ADD_CAPE.tcl — 最外层，注册 HDL core 和连接
参考 BGS/ADD_CAPE.tcl，关键步骤：


puts "======== Add cape option: PIXEL_PROC ========"

# ---- Step 1: 注册你的 HDL 模块为 Libero core ----
create_hdl_core -file $project_dir/hdl/pixel_compute.v \
    -module {pixel_compute} -library {work} -package {}

# ---- Step 2: 给 core 绑定 APB slave 总线接口 ----
hdl_core_add_bif -hdl_core_name {pixel_compute} \
    -bif_definition {APB:AMBA:AMBA2:slave} \
    -bif_name {BIF_1} -signal_map {}

# ---- Step 3: 把 Verilog 端口映射到 BIF 信号 ----
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PADDR}   -core_signal_name {paddr}
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PENABLE} -core_signal_name {penable}
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PWRITE}  -core_signal_name {pwrite}
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PRDATA}  -core_signal_name {prdata}
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PWDATA}  -core_signal_name {pwdata}
hdl_core_assign_bif_signal -hdl_core_name {pixel_compute} \
    -bif_name {BIF_1} -bif_signal_name {PSELx}   -core_signal_name {psel}
# 重命名 BIF (习惯)
hdl_core_rename_bif -hdl_core_name {pixel_compute} \
    -current_bif_name {BIF_1} -new_bif_name {APB_TARGET}

# ---- Step 4: Source 共享子模块和自定义 CAPE.tcl ----
::safe_source script_support/components/CAPE/shared/APB_BUS_CONVERTER.tcl
::safe_source script_support/components/CAPE/shared/CoreAPB3_CAPE.tcl
::safe_source script_support/components/CAPE/shared/CAPE_DEFAULT_GPIOS.tcl
# ... 你需要的 shared 模块 ...
::safe_source script_support/components/CAPE/$cape_option/CAPE.tcl

# ---- Step 5: 禁用 pad 自动 promote ----
auto_promote_pad_pins -promote_all 0

# ---- Step 6: 创建顶层 P8/P9 端口 (即使不用也要声明) ----
set sd_name ${top_level_name}
sd_create_bus_port -sd_name ${sd_name} -port_name {P8} \
    -port_direction {INOUT} -port_range {[46:3]} -port_is_pad {1}
# ... P9 端口同理 ...

# ---- Step 7: 修改 BVF_RISCV_SUBSYSTEM (如移除不用的 MSS 外设) ----
set sd_name {BVF_RISCV_SUBSYSTEM}
adapter::remove_pin "SPI_1_SS1"
adapter::remove_pin "SPI_1_CLK"
# ... 移除不需要的 pin ...
save_smartdesign -sd_name ${sd_name}
sd_update_instance -sd_name ${top_level_name} -instance_name ${sd_name}
generate_component -component_name ${sd_name}

# ---- Step 8: 实例化 CAPE SmartDesign ----
set sd_name ${top_level_name}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE} -instance_name {CAPE}

# ---- Step 9: 连接时钟和复位 ----
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN"}

# ---- Step 10: 最关键 — 连接 APB 总线 ----
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"CAPE:APB_SLAVE" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}
最重要的几行（第1-12行和第86行）：

create_hdl_core — 告诉 Libero 你的 Verilog 文件是一个可实例化的 core
hdl_core_add_bif — 给这个 core 加上 APB 总线接口
hdl_core_assign_bif_signal — 把 Verilog 的端口名映射到 APB 标准信号名
sd_connect_pins ... CAPE:APB_SLAVE ... CAPE_APB_MTARGET — 把 CAPE 的 APB 从端口连到 MSS 的 APB 主端口
2.2 CAPE.tcl — CAPE 内部 SmartDesign
参考 ROBOTICS/CAPE.tcl。在 CAPE 内部：

创建 CAPE SmartDesign
实例化 APB_BUS_CONVERTER、CoreAPB3_CAPE
使能一个新的 APB slot（比如 slot 6）
实例化你的 pixel_compute 模块
把 pixel_compute 的 APB_TARGET 连到 CoreAPB3 的对应 slave 口

# 在 CAPE.tcl 中：

# 使能 slot 6（之前可能是 false）
configure_core -component_name {CoreAPB3_CAPE} -params { "APBSLOT6ENABLE:true" }

# 实例化你的模块
sd_instantiate_hdl_core -sd_name ${sd_name} \
    -hdl_core_name {pixel_compute} -instance_name {pixel_compute_0}

# 连接到 CoreAPB3 的 slot 6
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"CoreAPB3_CAPE_0:APBmslave6" "pixel_compute_0:APB_TARGET"}

# 连接时钟和复位
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"PCLK" "pixel_compute_0:pclk"}
sd_connect_pins -sd_name ${sd_name} -pin_names \
    {"PRESETN" "pixel_compute_0:presetn"}
地址计算
CoreAPB3 使用 UPR_NIBBLE_POSN:5 + MADDR_BITS:24。Slot 地址解码如下：

Slot	偏移	物理地址
0	0x000000	0x41000000
1	0x100000	0x41100000
2	0x200000	0x41200000
3	0x300000	0x41300000
4	0x400000	0x41400000
5	0x500000	0x41500000
6	0x600000	0x41600000
7	0x700000	0x41700000
如果你的模块挂在 slot 6，基地址就是 0x41600000，你的寄存器偏移如上（0x00, 0x10, 0x20...）。

第三步：修改 Device Tree Overlay
参考 robotics-cape.dtso 和 udmabuf-overlay.dtso。

创建你的 overlay 文件，比如 pixel-proc.dtso：


// SPDX-License-Identifier: (GPL-2.0 OR MIT)
/* Copyright (c) 2024 Microchip Technology Inc */

/dts-v1/;
/plugin/;

// 标识这个 overlay
&{/chosen} {
    overlays {
        PIXEL-PROC-GATEWARE = "GATEWARE_GIT_VERSION";
    };
};

// 在 fabric-bus 下注册你的外设
&{/fabric-bus@40000000} {
    #address-cells = <2>;
    #size-cells = <2>;

    // 你的 pixel_compute 模块 (slot 6 = 0x41600000)
    pixel_proc: pixel-proc@41600000 {
        compatible = "generic-uio";          // 使用 UIO 框架
        reg = <0x0 0x41600000 0x0 0x1000>;  // 基地址, 大小 4KB
        status = "okay";
        symlink = "pixel-proc";
    };
};

// ========================================
// 如果你需要用 PDMA + udmabuf (参考 SMARTHLS)
// ========================================
// 注意：udmabuf 的节点需要写在根层级 {/} 下
&{/} {
    // 方法1: 使用 mpfs-dma-proxy (PDMA 用户态访问)
    // 注意：pdma 和 dma_non_cached_low 必须在 base device tree 中存在
    mpfs_dma_proxy: mpfs-dma-proxy {
        compatible = "microchip,mpfs-dma-proxy";
        dmas = <&pdma 0>, <&pdma 1>;
        dma-names = "dma-proxy0", "dma-proxy1";
    };

    udmabuf_pixel {
        compatible = "ikwzm,u-dma-buf";
        device-name = "udmabuf-pixel";
        minor-number = <0>;
        size = <0x0 0x2000000>;             // 32 MiB, 按需调整
        memory-region = <&dma_non_cached_low>;
        sync-mode = <3>;
    };
};
关键点：

compatible = "generic-uio" 让你的外设在 Linux 下自动生成 /dev/uioX 设备
reg 的格式是 <addr-high addr-low size-high size-low>
GATEWARE_GIT_VERSION 是构建时自动替换的占位符
第四步：使用 DMA（Linux 侧）
4.1 PDMA 方式（用户态 DMA）
应用 udmabuf-overlay.dtso 后：


#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

int main() {
    // 1. 打开 UIO 设备访问你的寄存器
    int uio_fd = open("/dev/uio0", O_RDWR);  // 对应 pixel_proc
    void *regs = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE,
                      MAP_SHARED, uio_fd, 0);

    // 2. 打开 udmabuf 设备
    int dma_fd = open("/dev/udmabuf-pixel", O_RDWR);
    void *dma_buf = mmap(NULL, 0x2000000, PROT_READ|PROT_WRITE,
                         MAP_SHARED, dma_fd, 0);

    // 3. 从硬盘加载像素数据到 DMA buffer
    FILE *fp = fopen("pixels.bin", "rb");
    fread(dma_buf, 1, pixel_data_size, fp);
    fclose(fp);
    msync(dma_buf, pixel_data_size, MS_SYNC);  // 确保写入 DDR

    // 4. 打开 PDMA proxy 设备
    int pdma_fd = open("/dev/dma-proxy0", O_RDWR);

    // 5. 配置寄存器
    volatile uint32_t *reg32 = (volatile uint32_t *)regs;
    reg32[0x10/4] = pixel_data_size;   // PIXEL_COUNT (offset 0x40 → word index)
    reg32[0x20/4] = 100;               // THRESHOLD
    reg32[0x30/4] = 128;               // REF_VALUE
    reg32[0x00/4] = 0x1;               // CONTROL: start

    // 6. 启动 PDMA 传输 (具体取决于 mpfs-dma-proxy 的 ioctl 接口)
    // ... (参考 mpfs-dma-proxy 驱动文档)

    // 7. 等待中断或轮询 STATUS
    while (reg32[0x00/4] & 0x1) {
        usleep(1000);  // 等待 busy 清零
    }

    // 8. 读取结果
    uint32_t result = reg32[0x50/4];   // RESULT_REG

    printf("Result: %u\n", result);

    // 9. 清理
    munmap(regs, 0x1000);
    munmap(dma_buf, 0x2000000);
    return 0;
}
4.2 不使用 DMA 的简单寄存器访问
如果你暂时先用最简单的方式（CPU 直接通过寄存器推数据），可以不用 PDMA/udmabuf，直接用 /dev/mem 访问 APB 地址空间：


#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>

#define PIXEL_PROC_BASE  0x41600000

int main() {
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    volatile uint32_t *regs = (volatile uint32_t *)mmap(
        NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, PIXEL_PROC_BASE);

    regs[0x10/4] = threshold;   // offset 0x10 → word index 0x10/4 = 4
    regs[0x00/4] = 0x1;         // start
    while (regs[0x00/4] & 0x1); // wait
    uint32_t result = regs[0x50/4];

    munmap((void *)regs, 0x1000);
    close(fd);
}
完整文件结构（你需要创建的）

sources/FPGA-design/script_support/components/CAPE/PIXEL_PROC/
├── ADD_CAPE.tcl               ← 注册 HDL core + 顶层连线
├── CAPE.tcl                   ← CAPE 内部 SmartDesign (实例化 CoreAPB3 + 你的模块)
├── HDL/
│   └── pixel_compute.v        ← 你的 Verilog 模块
├── device-tree-overlays/
│   └── pixel-proc.dtso        ← Device tree overlay
└── constraints/               ← 可选: IO 约束
    └── ...
从哪里开始最省力：复制 VERILOG_TEMPLATE/ 或 BGS/ 目录作为起点，然后：

修改 ADD_CAPE.tcl 中的 create_hdl_core 指向你的 Verilog 文件
修改 CAPE.tcl 中 CoreAPB3_CAPE 使能对应 slot，添加你的模块实例
在 device-tree-overlays/ 中更新 overlay
修改 ADD_CAPE.tcl 中不需要的 pin 配置（如果你不需要 P8/P9 GPIO）
总结：寄存器是你的控制接口
在你的场景中，寄存器 = 控制通道。模块需要的寄存器包括：

寄存器	地址偏移	方向	用途
CONTROL	0x00	RW	bit0=start, bit1=...
STATUS	0x10	RO	bit0=busy, bit1=done, bit2=error
THRESHOLD	0x20	RW	阈值
REF_VALUE	0x30	RW	参考值
PIXEL_COUNT	0x40	RW	总像素数
RESULT	0x50	RO	汇总结果
CPU 的流程就是：写寄存器配置 → 写 start bit → 等 STATUS.done 或中断 → 读 RESULT。

如果你确认了具体的计算逻辑，我可以帮你把 Verilog 的 RUNNING 状态里的计算部分填完整。