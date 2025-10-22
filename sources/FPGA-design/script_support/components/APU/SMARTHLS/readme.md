## Overview

[SmartHLS](https://www.microchip.com/en-us/products/fpgas-and-plds/fpga-and-soc-design-tools/smarthls-compiler) is a tool included with Libero that can automatically compile a C/C++ program into hardware described in Verilog HDL (Hardware Description Language). The generated hardware can then be integrated into the BeagleV Fire reference design.

The YAML configuration file for an example showing how SmartHLS can be used with the BeagleV Fire board is in `build-options/sin-shls-apu.yaml`. This example runs the `sin_performance` project from the [SmartHLS open source Math Library](https://github.com/MicrochipTech/fpga-hls-libraries). It is meant to show the performance increase when running the `sin` math function on the FPGA fabric versus on the CPU. For more details, see the project [readme](https://github.com/MicrochipTech/fpga-hls-libraries/blob/main/math/examples/riscv_tests/sources/sin_performance/readme.md).


## Prerequisites
First, make sure your license has been set up correctly (Same license as Libero). For a step-by-step guide on how to do this, see the [Setup steps](https://docs.beagleboard.org/boards/beaglev/fire/demos-and-tutorials/mchp-fpga-tools-installation-guide.html).

Also, make sure that `$(SMARTHLS_INSTALL_DIR)/SmartHLS/bin` is on your PATH. You can check by running the following command:
```
shls -v
```
If SmartHLS has successfully been added to your PATH, you should see this after running the previous command:
```
Smart High-Level Synthesis Tool Version 20XY.Z
```

## Running the Example

1. First, in the `gateware` directory, run the following to generate the hardware required to run the design.

   ```bash
   python build-bitstream.py build-options/sin-shls-apu.yaml
   ```

   This configuration file makes it so that SmartHLS's open-source library, [fpga-hls-libraries](https://github.com/MicrochipTech/fpga-hls-libraries), will be cloned in order to get the design files before starting to run the Libero flow. Then, as part of the project generation step, it will generate the SmartHLS hardware module (compile the C++ source code to Verilog), generate a RISC-V binary executable (.elf file) to run on board, and then integrate the hardware generated module into the Libero design. The rest of the bitstream generation flow proceeds as normal.

2. Find your board's IP address. To check, on your board, in the terminal, type `ifconfig`:

   ```
   $ ifconfig eth0
   eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
      inet 192.168.7.2  netmask 255.255.255.0  broadcast 192.168.0.255
      inet6 fe80::204:a3ff:fefb:406f  prefixlen 64  scopeid 0x20<link>
      ether 00:04:a3:fb:40:6f  txqueuelen 1000  (Ethernet)
      RX packets 17882  bytes 3231759 (3.0 MiB)
      RX errors 0  dropped 4843  overruns 0  frame 0
      TX packets 4963  bytes 1478718 (1.4 MiB)
      TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
      device interrupt 18
   ```

   In this example, 192.168.7.2 is the board's IP address. This may be different for your board.

3. Once you have generated the bitstream, copy the `bitstream` folder over to the board, and program the generated bitstream and associated .dtbo files to the board using the [reprogramming](https://docs.beagleboard.org/latest/boards/beaglev/fire/demos-and-tutorials/gateware/upgrade-gateware.html#launch-reprogramming-of-beaglev-fire-s-fpga) script, `/usr/share/beagleboard/gateware/change-gateware.sh`. E.g., run:

   ```bash
   scp -r <PATH TO GATEWARE REPO>/bitstream beagle@192.168.7.2

   ssh beagle@192.168.7.2
   sudo su root
   /usr/share/beagleboard/gateware/change-gateware.sh ~/bitstream
   ```

4. To run the executable, you will need to be running as `sudo`. Them ssh into your board and run the binary you just copied over as sudo inside the
/bitstream/SmartHLS_Executables/SHLS_X directory.

   ```bash
   ssh beagle@192.168.7.2

   sudo ./sin_performance.accel.elf
   ```

   You should see something like this:
   ```
   Passed! Times: cmath: 0.004770 s, hls_math: 0.000616 s
   ```
   The exact times it takes to run will vary.


   Note: If you have already generated the bitstream and want to change the C++ code, if you change anything that affects the top-level function (i.e. anything that will be generated into hardware), you will need to regenerate the bitstream (i.e. follow all the steps above again.) If the change only affects the software (e.g. `main()`) and not the top-level function, then you will only need to re-compile the software. To do this, go into the cloned libraries repo, and navigate to `math/examples/riscv_tests/sin_performance/beaglev_fire`, and run

   ```bash
   shls clean
   shls -a soc_sw_compile_accel
   ```

   This will generate a new executable under the `hls_output` directory, which you can copy to your BeagleV-Fire board and run.


## The Device Tree Overlay

### Overview

In order for the version of Ubuntu the BeagleBoard supports to be compatible with SmartHLS, we must make changes to the device tree.
The device tree overlay files associated with SmartHLS are inside the `APU/SMARTHLS/device-tree-overlay` directory.
One can add or edit `.dtso` files as needed by the target SmartHLS project.

The `udmabuf-overlay.dtso` contains the device nodes needed to enable the necessary memory allocation and DMA support for SmartHLS on Ubuntu20.04 on the BeagleFire-V board:

* mpfs_dma_proxy : DMA proxy nodes used as DMA channels by the PDMA device
* udmabuf0: The Device node exposing the DMA buffer to the userspace

### Using the Device Tree Overlay

The [bitstream generation python flow](../../../../../../build-bitstream.py) automatically generates the device tree overlay required by SmartHLS projects.
Once you have run the flow, you will need to program the generated bitstream and associated .dtbo files to the Beagle Board using the [reprogramming](https://docs.beagleboard.org/latest/boards/beaglev/fire/demos-and-tutorials/gateware/upgrade-gateware.html#launch-reprogramming-of-beaglev-fire-s-fpga) script, `/usr/share/beagleboard/gateware/change-gateware.sh`.

To confirm the device tree blob has been applied, you can run `dmesg | grep "udmabuf"`, and confirm the output looks like this:
```
[    3.991896] u-dma-buf udmabuf-ddr-nc-lb0: driver version = 3.2.4
[    3.997961] u-dma-buf udmabuf-ddr-nc-lb0: major number   = 244
[    4.003833] u-dma-buf udmabuf-ddr-nc-lb0: minor number   = 0
[    4.009536] u-dma-buf udmabuf-ddr-nc-lb0: phys address   = 0x00000000c4000000
[    4.016715] u-dma-buf udmabuf-ddr-nc-lb0: buffer size    = 33554432
[    4.023023] u-dma-buf udmabuf0: driver installed.
```