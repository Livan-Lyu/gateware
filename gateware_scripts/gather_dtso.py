# Gather device tree overlay dtso files from the gateware's
# script_support/components/<component-name>/<build-option-name>/device-tree-overlay
# directories into the bitstream builder's work/dtbo/context-0/<component-name>
# directories.
import os
import shutil
import sys
import yaml


def gather_dtso(gateware_dir, work_dir, build_options):
    context_dir = os.path.join(gateware_dir, "script_support", "components")
    board_options_path = os.path.join(os.path.dirname(os.path.dirname(gateware_dir)), "board-options", "board-selection.yaml")
    print(f"Board options path: {board_options_path}")

    board_selected = None
    die_selected = None
    package_selected = None
    
    
    if not os.path.exists(board_options_path):
        print(f"Error: Board options file not found at {board_options_path}")
        sys.exit(1)

    with open(board_options_path, 'r') as f:
        board_data = yaml.safe_load(f)

    # First get the selected board from the YAML
    board_selected = board_data.get('Board_Selected')
    if not board_selected:
        print("Error: 'Board_Selected' key missing in board-options YAML.")
        sys.exit(1)

    # Then get the boards configuration
    boards = board_data.get('Boards')
    if not boards:
        print("Error: 'Boards' key missing in board-options YAML.")
        sys.exit(1)

    # Get the selected board's parameters
    if board_selected not in boards:
        print(f"Error: Board {board_selected} not found in board-options.")
        sys.exit(1)

    board_params = boards[board_selected]
    print("The board selected is:", board_selected)
    
    die_selected = board_params.get('Die')
    package_selected = board_params.get('Package')


    build_options_dict = {}
    if build_options != 'NONE':
        options = build_options.split()
        for option in options:
            opt = option.split(':')
            le = len("_OPTION")
            component_dir = opt[0][:-le]
            option_dir = opt[1]
            build_options_dict[component_dir] = option_dir


    dtbo_dir = os.path.join(work_dir, "dtbo")
    if not os.path.exists(dtbo_dir):
        os.makedirs(dtbo_dir)
    os.makedirs(dtbo_dir, exist_ok=True)

    context_0_dir = os.path.join(dtbo_dir, "context-0")
    if not os.path.exists(context_0_dir):
        os.makedirs(context_0_dir)
    os.makedirs(context_0_dir, exist_ok=True)

    dtso_subpath = os.path.join(
        'device-tree-overlay',
        board_selected,
        die_selected,
        package_selected
    )

    print("Path to dtso files: ", dtso_subpath)

    for root, _, files in os.walk(context_dir):
        for file in files:
            if file.endswith(".dtso") or file.endswith(".dtbo"):
                if dtso_subpath in root:
                    component_name = os.path.relpath(root, context_dir).split(os.sep)[0]

                    option_name = os.path.relpath(root, context_dir).split(os.sep)[1]
                    if component_name in build_options_dict:
                        desired_option = build_options_dict[component_name]
                    else:
                        desired_option = 'DEFAULT'

                    if option_name == desired_option:
                        print("  Device tree overlay selected:")
                        print("    component:                ", component_name)
                        print("    build option:             ", option_name)
                        print("    device tree overlay file: ", file)
                        component_dir = os.path.join(context_0_dir, component_name)
                        if not os.path.exists(component_dir):
                            os.makedirs(component_dir)
                        src_path = os.path.join(root, file)
                        dst_path = os.path.join(component_dir, file)
                        shutil.copy(src_path, dst_path)

def parse_yaml(yaml_file):
    with open(yaml_file, 'r') as file:
        data = yaml.safe_load(file)
    return data

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Two arguments expected: gateware and work directory paths.")
        exit()

    yaml_file = sys.argv[1]
    config = parse_yaml(yaml_file)

    argumentList = sys.argv[1:]
    gateware_dir = argumentList[0]
    work_dir = argumentList[1]
    build_options = ' '.join(argumentList[2:]) if len(argumentList) > 2 else ''

    if os.path.exists(gateware_dir):
        if os.path.exists(work_dir):
            gather_dtso(gateware_dir, work_dir, argumentList[2:])
        else:
            print("Invalid bitstream builder work directory.")
    else:
        print("Gateware directory does not exist.")
