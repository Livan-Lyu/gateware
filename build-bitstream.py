# The BeagleV Fire Bitstream Builder is released under the following software license:

#  Copyright 2021 Microchip Corporation.
#  SPDX-License-Identifier: MIT


#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to
#  deal in the Software without restriction, including without limitation the
#  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
#  sell copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:

#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.

#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
#  IN THE SOFTWARE.


# The BeagleV Fire Bitstream Builder is an evolution of the Microchip
# Bitstream Builder available from:
# https://github.com/polarfire-soc/icicle-kit-minimal-bring-up-design-bitstream-builder
# 


import argparse
import os
import sys

import gateware_scripts
from gateware_scripts.build_gateware import build_gateware


global build_options_yaml_file
global board_options_yaml_file


# Parse command line arguments and set tool locations
def parse_arguments():
    global build_options_yaml_file
    global board_options_yaml_file

    # Initialize parser
    parser = argparse.ArgumentParser()

    parser.add_argument('Path',
                       metavar='path',
                       type=str,
                       help='Path to the YAML file describing the list of sources used to build the bitstream.')

    parser.add_argument('board_options_path',
                         nargs='?',
                         metavar='board_options_path',
                         type=str,
                         default=None,
                         help='Optional: Path to the YAML file describing board-specific options.')

    # Read arguments from command line
    args = parser.parse_args()
    build_options_yaml_file_arg = args.Path
    board_options_yaml_arg = args.board_options_path

    if not os.path.isfile(build_options_yaml_file_arg):
        print("\r\n!!! The path specified for the build options YAML input file does not exist !!!\r\n")
        parser.print_help()
        sys.exit()

    build_options_yaml_file = os.path.abspath(build_options_yaml_file_arg)

    # board options file optional
    if board_options_yaml_arg:
        if not os.path.isfile(board_options_yaml_arg):
            print("\r\n!!! The path specified for the board options YAML input file does not exist !!!\r\n")
            sys.exit()
        board_options_yaml_file = os.path.abspath(board_options_yaml_arg)
    else:
        board_options_yaml_file = None


def main():
    global build_options_yaml_file
    global board_options_yaml_file

    parse_arguments()

    build_gateware(build_options_yaml_file, board_options_yaml_file, ".", ".")


if __name__ == '__main__':
    main()
