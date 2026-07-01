  Why the Problem Happened

  The project was originally developed for Microchip Libero SoC v2022.3–v2024.x,
  which used COREAXI4INTERCONNECT v2.5.x. In that version, all AXI interconnect
  parameters were user-settable (resolve="user") and followed a MASTER/SLAVE
  naming convention (e.g., NUM_MASTERS, MASTER0_READ_SLAVE0, SLAVE0_START_ADDR).

  The development machine has Libero SoC v2025.1, which ships with
  COREAXI4INTERCONNECT v3.0.130. This version introduced two breaking changes:

  1. Complete parameter rename: MASTER → INITIATOR, SLAVE → TARGET across all
  1400+ parameters and BIF pin names. Old names like MASTER0_CHAN_RS simply
  don't exist anymore.
  2. Auto-derived parameters: Many formerly user-settable parameters became
  resolve="dependent" — the core derives them automatically and rejects manual
  assignment. This includes DWC_ADDR_FIFO_DEPTH_CEILING, all READ_INTERLEAVE,
  CROSSBAR_MODE, NUM_THREADS, OPEN_TRANS_MAX, RD_ARB_EN, and *AXI4PRT_*.

  Additionally, the build pipeline re-clones sources/MSS/ from a git bundle on
  every run, so any manual TCL fixes in that tree are lost immediately.

  Changes Made

  gateware_scripts/build_gateware.py — one new function + one call added (no
  logic changed in existing code):

  - _patch_coreaxi4_tcl_files() (line ~1138): Runs after MSS clone, before
  Libero invocation. For every .tcl file containing COREAXI4INTERCONNECT:
    - Removes 10 now-dependent parameter patterns (DWC_ADDR_FIFO_DEPTH_CEILING,
  READ_INTERLEAVE, NUM_THREADS, OPEN_TRANS_MAX, CROSSBAR_MODE, RD_ARB_EN,
  AXI4PRT_ADDRDEPTH, AXI4PRT_DATADEPTH, etc.)
    - Renames global params: NUM_MASTERS→NUM_INITIATORS, NUM_SLAVES→NUM_TARGETS,
  SLV_AXI4PRT→TRGT_AXI4PRT
    - Renames all per-instance params: MASTER0_→INITIATOR0_ through
  MASTER15_→INITIATOR15_, SLAVE0_→TARGET0_ through SLAVE31_→TARGET31_
    - Renames access params: _READ_SLAVE→_READ_TARGET,
  _WRITE_SLAVE→_WRITE_TARGET
  - Second pass (all .tcl files): Renames BIF pin names
  AXI4mmaster→AXI4minitiator, AXI4mslave→AXI4mtarget (scoped to AXI4 only to
  avoid breaking APB3 pins like APB3mmaster).
  - import re added for regex matching.

  No other files were changed. The compute logic (CAPE.v, pattern_chk.v, etc.)
  and core design architecture are untouched.
