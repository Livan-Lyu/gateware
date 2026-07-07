Error: [100990981]:  SDCTRL05: Pin '' does not exist.
Error:  The command 'sd_connect_pins' failed.


============= SCRIPT EXECUTION ERROR =============
Script:        /home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl
Error Message:
File: script_support/components/M2/DEFAULT/ADD_M2_INTERFACE.tcl
Line: 43
Depth: 1
Caller File: /home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl
Caller Line: 268
Depth: 2
Stack Trace:

    while executing
"sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:M2_APB_MTARGET" "M2_INTERFACE_0:APB_TARGET"}"
    (file "script_support/components/M2/DEFAULT/ADD_M2_INTERFACE.tcl" line 43)
    invoked from within
"source script_support/components/M2/$m2_option/ADD_M2_INTERFACE.tcl"
    (file "/home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl" line 268)
    invoked from within
"source /home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list source $script]"
=================================================


============= SCRIPT EXECUTION ERROR =============
Script:        /home/livan/gateware/gateware/sources/MSS/scripts/B_V_F_recursive.tcl
Error Message:
File: script_support/components/M2/DEFAULT/ADD_M2_INTERFACE.tcl
Line: 43
Depth: 1
Caller File: /home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl
Caller Line: 268
Depth: 2
Stack Trace:

    while executing
"sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:M2_APB_MTARGET" "M2_INTERFACE_0:APB_TARGET"}"
    (file "script_support/components/M2/DEFAULT/ADD_M2_INTERFACE.tcl" line 43)
    invoked from within
"source script_support/components/M2/$m2_option/ADD_M2_INTERFACE.tcl"
    (file "/home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl" line 268)
    invoked from within
"source /home/livan/gateware/gateware/sources/MSS/components/BVF_GATEWARE.tcl"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list source $script]"
    (procedure "safe_source" line 6)
    invoked from within
"safe_source [file join $INITIAL_DIRECTORY "sources" "MSS" "components" "BVF_GATEWARE.tcl"]"
    (file "/home/livan/gateware/gateware/sources/MSS/scripts/B_V_F_recursive.tcl" line 32)
    invoked from within
"source /home/livan/gateware/gateware/sources/MSS/scripts/B_V_F_recursive.tcl"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list source $script]"
=================================================
Error:  Failure when executing Tcl script. [ Line 286 ]
Error:  The Execute Script command failed.
The BVF_GATEWARE_025T project was closed.
