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
    coreparams_v = os.path.join(
        work_libero_dir,
        "component",
        "Actel",
        "DirectCore",
        "COREAXI4INTERCONNECT",
        "3.0.130",
        "coreparameters.v",
    )

    for path in (xbar_v, coreparams_v):
        if not os.path.isfile(path):
            raise RuntimeError(f"Missing generated file: {path}")

    xbar_text = read_text(xbar_v)
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

    print("CAPE_AXI_XBAR generation verified: ADDR_WIDTH=38, ID_WIDTH=4, NUM_INITIATORS=1, NUM_TARGETS=1")


if __name__ == "__main__":
    main()
