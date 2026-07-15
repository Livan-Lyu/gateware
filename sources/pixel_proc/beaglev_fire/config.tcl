source $env(SHLS_ROOT_DIR)/examples/legup.tcl
# 旧版本（2024.2 及以前）：默认的 TCL 配置文件名叫 legup.tcl，配置命令为 legup-config。（原因是 SmartHLS 的前身是 LegUp，被 Microchip 收购后一直保留了旧命名）。
# 新版本（2025.2 及以后）：官方全面将 legup.tcl 替换为 shls.tcl，并将 Makefile 中的 legup-config 替换为 shls-config
set_project PolarFireSoC MPFS025T-FCVG484E Icicle_SoC
set_parameter POINTSTO_ANALYZE_HW_ONLY 1

#
# Parameters used for SoC integration
#
set_parameter SOC_BD_NAME                 shls_test
set_parameter SOC_DMA_ENGINE              HARD_DMA
set_parameter SOC_AXI_INITIATOR           BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_INITIATOR
set_parameter SOC_AXI_TARGET              BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET
set_parameter SOC_CLOCK                   CLOCKS_AND_RESETS:FIC_0_ACLK
set_parameter SOC_RESET                   CLOCKS_AND_RESETS:FIC_0_FABRIC_RESET_N
set_parameter SOC_FABRIC_BASE_ADDRESS     0x60000000
set_parameter SOC_FABRIC_SIZE             0x400000
set_parameter SOC_CPU_MEM_BASE_ADDRESS    0x80000000
set_parameter SOC_CPU_MEM_SIZE            0x60000000

set_parameter CLOCK_PERIOD 5
