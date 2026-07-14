# pixel_proc SmartHLS Accelerator

This project is copied from the official `sin_performance` SmartHLS BeagleV-Fire example and keeps the same SmartHLS integration flow.

## Accelerator Interface

The top-level hardware function is:

```cpp
void pixel_proc(uint32_t input[MAX_PIXELS * 24],
                uint8_t output[MAX_PIXELS],
                uint32_t pixel_count);
```

- `input`: DDR buffer base address, laid out as `24 * RGBX32` entries per pixel.
- `output`: DDR buffer base address, written as one byte per pixel.
- `pixel_count`: number of pixels to process, capped in hardware at `MAX_PIXELS`.

Output values are:

- `0`: background
- `255`: foreground

History update remains software-owned. The accelerator only performs segmentation.

## BeagleV-Fire Build

From the BeagleV-Fire gateware directory:

```bash
python3 build-bitstream.py build-options/pixel-proc-shls-apu.yaml
```

The generated RISC-V test binary is:

```bash
sources/pixel_proc/beaglev_fire/hls_output/pixel_proc.accel.elf
```
