# BeagleV Fire Gateware Builder

## Introduction
The BeagleV Fire gateware builder is a Python script that builds both the PolarFire SoC HSS bootloader and Libero FPGA project into a single programming bitstream. It uses a list of repositories/branches specifying the configuration of the BeagleV Fire to build.


## Prerequisites
### Python libraries
The following Python libraries are used:
- GitPython
- PyYAML

```
pip3 install gitpython
pip3 install pyyaml
```

### Microchip Tools
The SoftConsole and Libero tools from Microchip are required by the bitstream builder.

The following environment variables are required for the bitstream builder to use the Microchip tools:
- SC_INSTALL_DIR
- FPGENPROG
- LIBERO_INSTALL_DIR
- LM_LICENSE_FILE

An example script for setting up the environment is available [here](https://openbeagle.org/beaglev-fire/Microchip-FPGA-Tools-Setup). 

## Usage

```
python3 build-bitstream.py <YAML Configuration File>
```

For example, the following command will be build the default beagleV Fire configuration:
```
python3 build-bitstream.py ./build-options/default.yaml
```


### YAML Configuration Files
The YAML configuration files are located in the "build-options" directory:

| Configuration File | Description                                                      |
| ------------------ | ---------------------------------------------------------------- |
| cape-4-uarts.yaml  | Similar to default but with all 4 serial ports routed.           |
| cape-comms.yaml    | Similar to default but supporting the Comms cape. No M.2.        |
| click-boards.yaml  | Similar to default but supporting the Click cape.                |
| default.yaml       | Default gateware including default cape and M.2 interface.       |
| minimal.yaml       | Minimal Linux system including Ethernet. No FPGA gateware.       |
| picorv-apu.yaml    | Similar to default but adds an additional RV CPU core.           |
| robotics.yaml      | Similar to default but supporting the Robotics cape.             |
| sin-shls-apu.yaml  | Adds a SmartHLS core optimised for sin calculations. [More](sources/FPGA-design/script_support/components/APU/SMARTHLS/readme.md)|

## Supported Platforms
The BeagleV Fire gateware builder has been tested on Ubuntu 20.04.

## Microchip bitstream-builder
The BeagleV-Fire gateware builder is derived from [Microchip's bitstream-builder](https://github.com/polarfire-soc/icicle-kit-minimal-bring-up-design-bitstream-builder).  
We recommend that you use either of these scripts as a starting point for your own PolarFire SoC FPGA designs as opposed to using Libero in isolation.

### New options for YAML Configuration
The configuration item of `type: git` now supports a `patches` array, which can be used to apply  
git formatted patches as needed, in case you don't have access to the referenced repository.

An example of the formatting can be seen below:
```yaml
HSS:
    type: git
    link: https://github.com/polarfire-soc/hart-software-services.git
    branch: next
    commit: af4f81a657c92601b0de2f52b89a3f97bbf4a2b3
    depth: 1
    patches:
        - 0001-Disable-annoying-debug-message.patch
        - 0002-Bring-back-old-DESIGNVER-formatting.patch
    make_clean: 0
```
Patch files will be found by searching the `patches/<object>` directory (`hss` in this instance).  
The `hss` fragment is the top-object name, "lower-cased".

The entire source repo can be cloned by setting `depth: full`. The depth can also be custom set as shown using `depth: 1`. A shallow clone is performed
if no depth info is provided.

## SmartHLS Support
[SmartHLS](https://www.microchip.com/en-us/products/fpgas-and-plds/fpga-and-soc-design-tools/smarthls-compiler) is a tool included with Libero that can automatically compile a C/C++ program into hardware described in Verilog HDL (Hardware Description Language). The generated hardware can then be integrated into the BeagleV Fire reference design.

We have included an example design that uses SmartHLS in `build-options/sin-shls-apu.yaml`.
