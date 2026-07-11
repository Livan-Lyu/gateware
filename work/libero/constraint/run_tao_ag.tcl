set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD} -range {EXT}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/hdl/apb_arbiter.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/CoreAPB3/4.2.100/rtl/vlog/core/coreapb3_muxptob3.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/CoreAPB3/4.2.100/rtl/vlog/core/coreapb3_iaddr_reg.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/CoreAPB3/4.2.100/rtl/vlog/core/coreapb3.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/FIC3_INITIATOR/FIC3_INITIATOR.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/MIV_IHC_C0/MIV_IHC_C0_0/rtl/core/core_merged/miv_ihc_core_merged.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/MIV_IHC_C0/MIV_IHC_C0.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/PF_SOC_MSS/PF_SOC_MSS.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/BVF_RISCV_SUBSYSTEM/BVF_RISCV_SUBSYSTEM.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/APB_BUS_CONVERTER/APB_BUS_CONVERTER.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_async_1deep_fwft_fifo.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_axi4s_initiator_if.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_axi4s_target_if.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_axi4s_if.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_dncnv_lsram.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_dncnv_reg.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_dncnv_usram.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_dncnv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_upcnv_lsram.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_upcnv_reg.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_upcnv_usram.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_buff_upcnv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_NstagesSync.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_grayToBinConv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_async.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_fwft.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_sync_scntr.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo_sync.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_corefifo.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4SFIFO/caxi4c_coreaxi4s_fifo.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/DualPort_FF_SyncWr_SyncRd.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/DualPort_Ram_SyncWr_SyncRd.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/FifoDualPort.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/InitiatorAddressDecoder.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/DependenceChecker.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/TransactionController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/InitiatorControl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/RegSliceFull.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/RegisterSlice.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/RoundRobinArb.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/TargetMuxController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/AddressController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/Revision.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/DERR_Target.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/RdFifoDualPort.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/ReadDataMux.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/RequestQual.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/ReadDataController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/RDataController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/TargetDataMuxController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/RespController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/WriteDataMux.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/WDataController.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/Axi4CrossBar.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/AHB_SM_Undefburst.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/IntrAHBtoAXI4Converter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4CrossBar/ResetSync.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/Bin2Gray.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/CDC_grayCodeCounter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/CDC_rdCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/CDC_wrCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/RAM_BLOCK.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/CDC_FIFO.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/IntrClockDomainCrossing.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_CmdFifoWriteCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/Hold_Reg_Ctrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_Hold_Reg_Rd.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_preCalcCmdFifoWrCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_widthConvrd.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/FIFO_CTRL.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/FIFO.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/byte2bit.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_readWidthConv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_Hold_Reg_Wr.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_widthConvwr.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_brespCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_DownConv_writeWidthConv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DownConverter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_AChannel.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_BChannel.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChannel_TrgtRid_Arb.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChan_Ctrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_preCalcRChan_Ctrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/FIFO_downsizing.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChannel.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChan_Hold_Reg.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChan_ReadDataFifoCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_Wchan_WriteDataFifoCtrl.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/FIFO_upsizing.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChannel.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/DWC_UpConv_preCalcAChannel.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/UpConverter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/IntrDataWidthConv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/IntrProtocolConverter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/InitiatorConvertor.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtClockDomainCrossing.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtDataWidthConverter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtAxi4ProtConvRead.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtAxi4ProtConvWrite.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtAxi4ProtocolConv.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtAxi4ProtConvAXI4ID.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TrgtProtocolConverter.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/Axi4Convertors/TargetConvertor.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/COREAXI4INTERCONNECT/3.0.130/rtl/vlog/core/CoreAxi4Interconnect.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CAPE_AXI_XBAR/CAPE_AXI_XBAR.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CAPE_DEFAULT_GPIOS/CAPE_DEFAULT_GPIOS.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/corepwm/4.5.100/rtl/vlog/core/tach_if.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/corepwm/4.5.100/rtl/vlog/core/pwm_gen.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/corepwm/4.5.100/rtl/vlog/core/reg_if.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/corepwm/4.5.100/rtl/vlog/core/timebase.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/Actel/DirectCore/corepwm/4.5.100/rtl/vlog/core/corepwm.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/corepwm_C1/corepwm_C1.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CAPE_PWM/CAPE_PWM.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CoreAPB3_CAPE/CoreAPB3_CAPE.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CoreGPIO_P8_UPPER/CoreGPIO_P8_UPPER_0/rtl/vlog/core/coregpio.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CoreGPIO_P8_UPPER/CoreGPIO_P8_UPPER.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/P8_GPIO_UPPER/P8_GPIO_UPPER.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CoreGPIO_P9/CoreGPIO_P9_0/rtl/vlog/core/coregpio.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CoreGPIO_P9/CoreGPIO_P9.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/P9_GPIO/P9_GPIO.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/hdl/apb_ctrl_status.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/hdl/pixel_proc.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/hdl/cape_regs.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CAPE/CAPE.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CORERESET/CORERESET_0/core/corereset_pf.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CORERESET/CORERESET.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/FPGA_CCC_C0/FPGA_CCC_C0_0/FPGA_CCC_C0_FPGA_CCC_C0_0_PF_CCC.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/FPGA_CCC_C0/FPGA_CCC_C0.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/INIT_MONITOR/INIT_MONITOR_0/INIT_MONITOR_INIT_MONITOR_0_PFSOC_INIT_MONITOR.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/INIT_MONITOR/INIT_MONITOR.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/OSCILLATOR_160MHz/OSCILLATOR_160MHz_0/OSCILLATOR_160MHz_OSCILLATOR_160MHz_0_PF_OSC.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/OSCILLATOR_160MHz/OSCILLATOR_160MHz.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/PF_CCC_ADC/PF_CCC_ADC_0/PF_CCC_ADC_PF_CCC_ADC_0_PF_CCC.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/PF_CCC_ADC/PF_CCC_ADC.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/CLOCKS_AND_RESETS/CLOCKS_AND_RESETS.v}
read_verilog -mode system_verilog {/home/livan/gateware/gateware/work/libero/component/work/MY_CUSTOM_FPGA_DESIGN_5AF3A212/MY_CUSTOM_FPGA_DESIGN_5AF3A212.v}
set_top_level {MY_CUSTOM_FPGA_DESIGN_5AF3A212}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/CAPE_AXI_XBAR/CAPE_AXI_XBAR_0/CAPE_AXI_XBAR.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/PF_CCC_ADC/PF_CCC_ADC_0/PF_CCC_ADC_PF_CCC_ADC_0_PF_CCC.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/FIC0_INITIATOR/FIC0_INITIATOR_0/FIC0_INITIATOR.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/CLK_DIV/CLK_DIV_0/CLK_DIV_CLK_DIV_0_PF_CLK_DIV.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/FPGA_CCC_C0/FPGA_CCC_C0_0/FPGA_CCC_C0_FPGA_CCC_C0_0_PF_CCC.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/TRANSMIT_PLL/TRANSMIT_PLL_0/TRANSMIT_PLL_TRANSMIT_PLL_0_PF_TX_PLL.sdc}
read_sdc -component {/home/livan/gateware/gateware/work/libero/component/work/PF_SOC_MSS/PF_SOC_MSS.sdc}
derive_constraints
write_sdc {/home/livan/gateware/gateware/work/libero/constraint/MY_CUSTOM_FPGA_DESIGN_5AF3A212_derived_constraints.sdc}
write_ndc {/home/livan/gateware/gateware/work/libero/constraint/MY_CUSTOM_FPGA_DESIGN_5AF3A212_derived_constraints.ndc}
write_pdc {/home/livan/gateware/gateware/work/libero/constraint/fp/MY_CUSTOM_FPGA_DESIGN_5AF3A212_derived_constraints.pdc}
