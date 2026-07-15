NAME = pixel_proc
SRCS = ../sources/test.cpp  

# Root directory path for the HLS libraries. Modify as necessary. 
SHLS_LIBRARY_DIR ?=  /home/livan/Microchip/Libero_SoC_2025.1/SmartHLS/SmartHLS

USER_CXX_FLAG += -I$(SHLS_LIBRARY_DIR)
USER_CXX_FLAG += -DMAX_PIXELS=2073600
USER_CXX_FLAG += -DINPUT_BYTES_PER_PIXEL=96

LOCAL_CONFIG = -shls-config=config.tcl

# 在 SmartHLS 中，BeagleC Fire 走的是 Cross-compile for MiV
# 在 Libero_SoC_2025.1/SmartHLS/SmartHLS/lib/python/hls/cross_compile_sw.py:356
#     # Building target
#     logging.info(f"Building target: {config.NAME}")
#     logging.info("Invoking: GNU RISC-V Cross C Linker")
#     run(
#         config,
#         external_paths.RISCV_TOOLS_SHLS.joinpath("riscv64-unknown-elf-gcc"),
#         [
#             *shared_compile_flags,
#             "-T",
#             "../riscv_hal/microsemi-riscv-ram.ld",
#             "-nostartfiles",
#             "-Xlinker",
#             "--gc-sections",
#             "-Wl,-Map," + config.NAME + ".map",
#             "-o",
#             config.NAME + ".elf",
#             *[obj.as_posix() for obj in list(riscv_project_dir.glob("**/*.o"))],
# ============================== add command to load user link flags ==============================
# note: the soft core MIV is 32-bit
#                 *_normalize_compiler_flags(config.USER_LINK_FLAG_RISCV),
# =================================================================================================
#             "-lstdc++",
#         ],