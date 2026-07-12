import os
import re
import sys


def read_text(path):
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        return f.read()


def expect(pattern, text, description):
    match = re.search(pattern, text)
    if not match:
        raise RuntimeError(f"Missing expected {description}")
    return match.group(1)


def main():
    if len(sys.argv) != 2:
        raise SystemExit("usage: verify_cape_axi_xbar.py <work-libero-dir>")

    work_libero_dir = sys.argv[1]
    xbar_v = os.path.join(work_libero_dir, "component", "work", "CAPE_AXI_XBAR", "CAPE_AXI_XBAR.v")
    cape_v = os.path.join(work_libero_dir, "component", "work", "CAPE", "CAPE.v")
    coreparams_v = os.path.join(
        work_libero_dir,
        "component",
        "Actel",
        "DirectCore",
        "COREAXI4INTERCONNECT",
        "3.0.130",
        "coreparameters.v",
    )

    for path in (xbar_v, cape_v, coreparams_v):
        if not os.path.isfile(path):
            raise RuntimeError(f"Missing generated file: {path}")

    xbar_text = read_text(xbar_v)
    cape_text = read_text(cape_v)
    coreparams_text = read_text(coreparams_v)

    addr_width = expect(r'parameter ADDR_WIDTH = (\d+);', coreparams_text, "ADDR_WIDTH")
    id_width = expect(r'parameter ID_WIDTH = (\d+);', coreparams_text, "ID_WIDTH")

    if addr_width != "38":
        raise RuntimeError(f"Unexpected ADDR_WIDTH={addr_width}, expected 38")
    if id_width != "4":
        raise RuntimeError(f"Unexpected ID_WIDTH={id_width}, expected 4")

    if '"NUM_INITIATORS:1"' not in xbar_text:
        raise RuntimeError("Generated CAPE_AXI_XBAR.v is missing NUM_INITIATORS:1")
    if '"NUM_TARGETS:1"' not in xbar_text:
        raise RuntimeError("Generated CAPE_AXI_XBAR.v is missing NUM_TARGETS:1")
    if '"TARGET0_START_ADDR:0x80000000"' not in xbar_text:
        raise RuntimeError("Generated CAPE_AXI_XBAR.v is missing TARGET0_START_ADDR:0x80000000")
    if '"TARGET0_END_ADDR:0xdfffffff"' not in xbar_text:
        raise RuntimeError("Generated CAPE_AXI_XBAR.v is missing TARGET0_END_ADDR:0xdfffffff")

    if "INITIATOR0_ARSIZE   ( INITIATOR0_ARSIZE_const_net_0 )" in cape_text:
        raise RuntimeError("Generated CAPE.v still ties INITIATOR0_ARSIZE to a SmartDesign constant")
    if "INITIATOR0_ARBURST  ( INITIATOR0_ARBURST_const_net_0 )" in cape_text:
        raise RuntimeError("Generated CAPE.v still ties INITIATOR0_ARBURST to a SmartDesign constant")
    if "INITIATOR0_ARLEN    ( INITIATOR0_ARLEN_const_net_0 )" in cape_text:
        raise RuntimeError("Generated CAPE.v still ties INITIATOR0_ARLEN to a SmartDesign constant")

    required_signals = (
        "cape_regs_0_AXI4_INITIATOR_ARLEN",
        "cape_regs_0_AXI4_INITIATOR_ARSIZE",
        "cape_regs_0_AXI4_INITIATOR_ARBURST",
        "cape_regs_0_AXI4_INITIATOR_ARLOCK",
        "cape_regs_0_AXI4_INITIATOR_ARCACHE",
        "cape_regs_0_AXI4_INITIATOR_ARPROT",
        "cape_regs_0_AXI4_INITIATOR_ARQOS",
        "cape_regs_0_AXI4_INITIATOR_ARREGION",
        "cape_regs_0_AXI4_INITIATOR_ARUSER",
        "cape_regs_0_AXI4_INITIATOR_RLAST",
    )
    for signal in required_signals:
        if signal not in cape_text:
            raise RuntimeError(f"Generated CAPE.v is missing explicit AXI signal {signal}")

    print("CAPE_AXI_XBAR and CAPE AXI sideband generation verified")


if __name__ == "__main__":
    main()
