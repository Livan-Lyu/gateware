NAME = pixel_proc
SRCS = ../sources/test.cpp  

# Root directory path for the HLS libraries. Modify as necessary. 
SHLS_LIBRARY_DIR ?=  ../../../../..

USER_CXX_FLAG += -I$(SHLS_LIBRARY_DIR)
USER_CXX_FLAG += -DMAX_PIXELS=2073600
USER_CXX_FLAG += -DINPUT_BYTES_PER_PIXEL=96
USER_LINK_FLAG_RISCV += -L$(SHLS_ROOT_DIR)/smarthls-library/hls -lhls_riscv64_accel
