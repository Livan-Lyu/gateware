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


# Packages which form part of Python's standard library
import shutil
import sys
import subprocess
import platform


def check_pip_installed():
    if shutil.which("pip") is None:
            print("Error: pip is not installed.")
            print("Please install pip first.")
            sys.exit()


def check_dtc_installed():
    if shutil.which("dtc") is None:
            print("Error: dtc (device-tree-compiler) is not installed")
            print("Please install it by running: sudo apt install device-tree-compiler")
            exit()

def check_pyyaml_installed():
    try:
        result = subprocess.run([sys.executable, "-m", "pip", "show", "pyyaml"],
                              capture_output=True, text=True)
        if result.returncode != 0 or "Name: PyYAML" not in result.stdout:
            raise ImportError
    except ImportError:
        print("Error: PyYAML is not installed.")
        print("Please install it by running: pip install pyyaml")
        sys.exit(1)

def check_gitpython_installed():
    try:
        result = subprocess.run([sys.executable, "-m", "pip", "show", "gitpython"],
                                capture_output=True, text=True)
        if result.returncode != 0 or "Name: GitPython" not in result.stdout:
            raise ImportError
    except ImportError:
        print("Error: GitPython is not installed.")
        print("Please install it by running: pip install gitpython")
        sys.exit()

# Allow libero to generate components (DMA_CONTROLLER) which require a display
def check_xvfb_installed():
    if shutil.which("xvfb-run") is None:
        print("Error: xvfb-run is not installed.")
        print("Please install it by running: sudo apt-get install xvfb")
        sys.exit()

# Check if SmartHLS tool is added to path, only to be run if SMARTHLS argument in yaml file
def check_shls_tool_status():
    try:
        result = subprocess.run(["shls", "-v"], capture_output=True, text=True, check=True)
        output = result.stdout.strip()

        # Expected output
        prefix = "Smart High-Level Synthesis Tool Version "

        if not output.startswith(prefix):
            print("Unexpected output from 'shls -v':", output)
            print("Check path to SmartHLS tool")
            sys.exit(1)

    except subprocess.CalledProcessError as e:
        print("Error running 'shls -v':", e)
        sys.exit(1)
    except Exception as e:
        print("SmartHLS has not been added to your path", e)
        sys.exit(1)

# Perform package checks before any other imports
if platform.system() == "Linux" or platform.system() == "Linux2":
    check_pip_installed()
    check_dtc_installed()
    check_pyyaml_installed()
    check_gitpython_installed()
    check_xvfb_installed()

import argparse
import io
import os
import zipfile
import git
import requests
import yaml
import datetime
import glob
import re

from gateware_scripts.generate_gateware_overlays import generate_gateware_overlays
from gateware_scripts.Logger import Logger


def exe_sys_cmd(cmd):
    proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in proc.stdout:
        ascii_line = line.decode('ascii')
        sys.stdout.write(ascii_line)
    proc.wait()


def check_native_platform():
    if os.path.isfile('/.dockerenv'):
        return ""
    else:
        return " --native"


def set_arguments(build_options_yaml_path, board_options_yaml_path=None):
    global libero
    global mss_configurator
    global softconsole_headless
    global programming
    global update
    global build_options_input_yaml_file
    global board_options_input_yaml_file

    if not os.path.isfile(build_options_yaml_path):
        print("\r\n!!! The path specified for the YAML input file does not exist !!!\r\n")
#        parser.print_help()
        sys.exit()

    build_options_input_yaml_file = os.path.abspath(build_options_yaml_path)

    # Tool call variables - these are the names of the tools to run which will be called from os.system.
    # Full paths could be used here instead of assuming tools are in PATH
    libero = "libero"
    mss_configurator = "pfsoc_mss"
    softconsole_headless = "softconsole-headless"

    update = False
    programming = False


# Parse command line arguments and set tool locations
def parse_arguments():
    global libero
    global mss_configurator
    global softconsole_headless
    global programming
    global update

    global build_options_input_yaml_file
    global board_options_input_yaml_file


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
                         help='Optional: Path to the YAML file describing board-specific options.')

    # Read arguments from command line
    args = parser.parse_args()
    build_options_yaml_arg = args.Path
    board_options_yaml_arg = args.board_options_path

    if not os.path.isfile(build_options_yaml_arg):
        print("\r\n!!! The path specified for the build options YAML input file does not exist !!!\r\n")
        parser.print_help()
        sys.exit()

    build_options_input_yaml_file = os.path.abspath(build_options_yaml_arg)

    if board_options_yaml_arg:
        if not os.path.isfile(board_options_yaml_arg):
            print("\r\n!!! The path specified for the board options YAML input file does not exist !!!\r\n")
            sys.exit()
        board_options_input_yaml_file = os.path.abspath(board_options_yaml_arg)
    else:
        board_options_input_yaml_file = None

    # Tool call variables - these are the names of the tools to run which will be called from os.system.
    # Full paths could be used here instead of assuming tools are in PATH
    libero = "libero"
    mss_configurator = "pfsoc_mss"
    softconsole_headless = "softconsole-headless"

    update = False
    programming = False


# Checks to see if all of the required tools are installed and present in path, if a needed tool isn't available the script will exit
def check_tool_status():
    if shutil.which("libero") is None:
        print("Error: libero not found in path")
        exit()

    if shutil.which("pfsoc_mss") is None:
        print("Error: polarfire soc mss configurator not found in path")
        exit()

    if os.environ.get('SC_INSTALL_DIR') is None:
        print(
            "Error: SC_INSTALL_DIR environment variable not set, please set this variable and point it to the "
            "appropriate SoftConsole installation directory to run this script")
        exit()

    if os.environ.get('FPGENPROG') is None:
        print(
            "Error: FPGENPROG environment variable not set, please set this variable and point it to the appropriate "
            "FPGENPROG executable to run this script")
        exit()

    path = os.environ["PATH"]

    if "riscv-unknown-elf-gcc" not in path:
        print(
            "The path to the RISC-V toolchain needs to be set in PATH to run this script")
        exit()

    if platform.system() == "Windows":
        print("Running on Windows host")
        wsl_distributions_resp = subprocess.run(['wsl', '-l'], stdout=subprocess.PIPE)
        wsl_distributions = wsl_distributions_resp.stdout.decode('utf-16')
        if "Windows Subsystem for Linux" not in wsl_distributions:
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print("!!! Windows Subsystem for Linux not found !!!")
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print("You need WSL to run the Linux device tree compiler on a Windows host to ")
            print("generate device tree overlays describing the complete gateware.")
            print("Without this, Linux will be unaware of the gateware's FPGA content.")
            input("Press Enter to continue generating gateware without device tree overlays: ")
        else:
            print("Windows Subsystem for Linux installed")
            resp = subprocess.run(['wsl', '-e', 'dtc', '-v'], stdout=subprocess.PIPE)
            dtc_version = resp.stdout.decode('ascii')
            if "Version: DTC" not in dtc_version:
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                print("!!! Device tree compiler not found !!!")
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                print("Please install the Linux device tree compiler in Windows Subsystem for Linux.")
                print("In WSL, use command: sudo apt install device-tree-compiler")
                input("Press Enter to continue generating gateware without device tree overlays: ")
            else:
                print("Found device tree compiler: ", dtc_version)


# Creates required folders and removes artifacts before beginning
def init_workspace():
    print("================================================================================")
    print("                              Initialize workspace")
    print("================================================================================\r\n", flush=True)

    # Create the sources folder to clone into if it doesn't exist (any existing source folders are handled in the
    # clone_sources function)
#    if not os.path.exists("./sources"):
#        os.mkdir("./sources")

    # Delete the work folder and its content if it exists.
    if os.path.exists("./work"):
        shutil.rmtree('./work')

    # Create each output subdirectory
    os.mkdir("./work")
    os.mkdir("./work/MSS")
    os.mkdir("./work/HSS")

    # Delete the bitstream folder if it exists to remove previously created bitstreams.
    if os.path.exists("./bitstream"):
        shutil.rmtree('./bitstream')

    # Create the bitstream folder structure. This is where the created bitstreams will be generated. There might be
    # multiple subdirectories there to provided different programming options.
    os.mkdir("./bitstream")
    os.mkdir("./bitstream/FlashProExpress")
    os.mkdir("./bitstream/LinuxProgramming")
    print("  The FlashPro Express bitstream programming job files will be stored in")
    print("  directory: ./bitstream/FlashProExpress\r\n", flush=True)


# clones the sources specified in the sources.yaml file
def clone_sources(source_list, gateware_top_dir):
    print("================================================================================")
    print("                                 Clone sources")
    print("================================================================================\r\n", flush=True)

    def do_patches(details, mss_variant):

        def apply_patches(patches, number: int):
            if patches is not None:
                if isinstance(number, int) and (number > 0):
                    print(f"Pass {number}:")
                for patch in patches:
                    patch_file = os.path.join(os.path.dirname(source_list), "..", "patches", source.lower(), patch)
                    try:
                        stat = repo.git.am(patch_file)
                        print(f"- {stat}")
                    except git.exc.GitCommandError as e:
                        print(f"Error with Git operations for {source}: {e}")
                        exit(e.status)

        if "patches" in details:
            patches = details["patches"]
            if isinstance(patches, list):
                print("Patching...")
                apply_patches(patches, 0)
            else:
                if isinstance(patches, dict):
                    if (details["patches"].get("common") or details["patches"].get(mss_variant)) is not None:
                        print("Patching...")
                        n = 1
                        patches = details["patches"].get("common")
                        if patches is not None:
                            apply_patches(patches, n)
                            n += 1
                        patches = details["patches"]["variants"].get(mss_variant)
                        if patches is not None:
                            if n == 1: n = 0
                            apply_patches(patches, n)

    def get_default_branch(repo_url):
        if 'bundle' in repo_url.lower():
            temp_dir = os.path.join("./sources", f"__temp__{source}")
            try:
                temp_repo = git.Repo.clone_from(repo_url, temp_dir, depth=1)
                default_branch = temp_repo.active_branch.name
                return default_branch
            except Exception as e:
                print(f"Warning: Could not determine default branch for {source}: {e}")
                return "master"  # fallback
            finally:
                if os.path.exists(temp_dir):
                    shutil.rmtree(temp_dir)
        else:
            try:
                result = subprocess.run(
                    ["git", "ls-remote", "--symref", repo_url, "HEAD"],
                    capture_output=True, text=True, check=True
                )
                for line in result.stdout.splitlines():
                    if line.startswith("ref:"):
                        # Example line: ref: refs/heads/main HEAD
                        return line.split("/")[-1].split()[0]
            except subprocess.CalledProcessError:
                pass
            return "master"  # fallback

    def get_first_valid_branch(repo_url):
        """
        Returns the first available branch name from the remote as a fallback.
        """
        try:
            result = subprocess.run(
                ["git", "ls-remote", "--heads", repo_url],
                check=True,
                capture_output=True,
                text=True
            )
            branches = re.findall(r"refs/heads/([^\s]+)", result.stdout)
            if branches:
                return branches[0]
        except subprocess.CalledProcessError:
            pass
        return "main"

    def get_commit_branch(repo_url, sha, source):
        temp_dir = os.path.join("./sources", f"__temp__{source}")
        try:
            temp_repo = git.Repo.clone_from(repo_url, temp_dir, depth=1)

            branches_with_commit = []

            for ref in temp_repo.branches:
                try:
                    # exploiting exception if ancestor isn't found
                    temp_repo.git.merge_base('--is-ancestor', sha, ref.name)
                    branches_with_commit.append(ref.name)
                except git.exc.GitCommandError:
                    pass

            return branches_with_commit
        except Exception as e:
            print(f"Warning: Could not determine commit branch for {source}: {e}")
            return []  # fallback
        finally:
            if os.path.exists(temp_dir):
                shutil.rmtree(temp_dir)

    def progressive_checkout(repo, commit_hash, max_depth=4096):
        """
        Tries to checkout a commit, progressively doubling the fetch depth until found.
        """
        current_depth = 1
        while current_depth <= max_depth:
            try:
                repo.git.checkout(commit_hash)
                print(f"Checked out commit '{commit_hash[:8]}'.")
                return
            except git.exc.GitCommandError:
                print(f"Commit '{commit_hash[:8]}' not found — fetching depth={current_depth * 2}...")
                try:
                    repo.git.fetch("--depth", str(current_depth * 2), "--tags")
                except Exception as e:
                    print(f"Warning: fetch failed (depth={current_depth * 2}): {e}")
                current_depth *= 2

        # Last resort: try full fetch
        print(f"Attempting full fetch as last resort...")
        try:
            repo.git.fetch("--unshallow")
            repo.git.checkout(commit_hash)
            print(f"Successfully checked out '{commit_hash}' after full fetch.")
            return
        except Exception as e:
            print(f"Failed to find commit '{commit_hash}' after fetching up to depth={max_depth}: {e}")
            sys.exit(1)

    source_directories = {}

    with open(source_list) as f:
        data = yaml.load(f, Loader=yaml.FullLoader)

    # An MSS key is now mandatory for the builder to function
    # Sanity checks follow:
    source = 'MSS'
    if source not in data:
        print(f"ERROR: {source} must be present in '{source_list}'. STOP!")
        sys.exit(1)

    details = data[source]

    if not isinstance(details, dict):
        print(f"ERROR: {source} must be a dictionary object in '{source_list}'. STOP!")
        sys.exit(1)

    source_type = details.get("type")
    local = details.get("local")
    link = details.get("link")

    commit = details.get("commit")
    target_branch = details.get("branch")

    if (source_type or "") != "git":
        print(f"ERROR: {source}: type must be 'git' in '{source_list}'. STOP!")
        sys.exit(1)

    if all([local is None, link is None]):
        print(f"ERROR: {source}: local or link must be present in '{source_list}'. STOP!")
        sys.exit(1)

    if local is not None:
        # local file must be valid
        link = os.path.join(gateware_top_dir, local)
        if not os.path.exists(link):
            print(f"ERROR: {source}: local must be valid in '{source_list}'. STOP!")
            sys.exit(1)

    if not target_branch:
        target_branch = get_default_branch(link) if not commit else get_commit_branch(link, commit, source)

    if isinstance(target_branch, list):
        if len(target_branch) == 1:
            target_branch = target_branch[0]
        else:
            print(f"ERROR: {source}: commit search inconclusive in '{source_list}'. STOP!")
            sys.exit(1)

    mss_variant = target_branch
    print(f"MSS Variant: {mss_variant.upper()}\n")

    for source, details in data.items():
        if source == "gateware":
            continue

        # --- Print a header for this repo section ---
        print(f"{source.upper()}:")  # e.g. "HSS:"

        source_type = details.get("type")
        source_dir = os.path.join("./sources", source)
        local = details.get("local")
        repo_url = details.get("link") if local is None else os.path.join(gateware_top_dir, local)
        branch = details.get("branch")
        commit = details.get("commit")
        if 'mss' in source.lower():
            depth = "full"
        else:
            depth = details.get("depth", 1)

        # --- Handle ZIP or DOWNLOAD sources ---
        if source_type in ("zip", "download"):
            if os.path.exists(source_dir):
                shutil.rmtree(source_dir)
            os.makedirs(source_dir, exist_ok=True)

            try:
                response = requests.get(repo_url)
                response.raise_for_status()

                if source_type == "zip":
                    with zipfile.ZipFile(io.BytesIO(response.content)) as z:
                        z.extractall(source_dir)
                    print(f"Extracted ZIP archive for {source}.")
                else:
                    file_name = os.path.basename(repo_url)
                    file_path = os.path.join(source_dir, file_name)
                    with open(file_path, "wb") as f:
                        f.write(response.content)
                    print(f"Downloaded {source} to {file_path}")

                source_directories[source] = source_dir
            except Exception as e:
                print(f"Error downloading {source}: {e}")
            print()  # blank line after this repo
            continue

        # --- Handle GIT sources ---
        if source_type != "git":
            print(f"Unknown source type '{source_type}' for {source}. Skipping.\n")
            continue
        if not repo_url:
            print(f"No repository link for {source}. Skipping.\n")
            continue

        link_file = os.path.join(source_dir, "repo_link.txt")
        repo = None

        # --- If repo exists, check link and update ---
        if os.path.exists(source_dir):
            # Check if link has changed
            old_link = None
            if os.path.exists(link_file):
                with open(link_file, 'r') as lf:
                    old_link = lf.read().strip()

            if old_link is None:
                try:
                    repo = git.Repo(source_dir)
                    old_link = repo.remotes.origin.url
                except Exception:
                    pass

            if old_link != repo_url:
                print(f"Repository link changed. Replacing folder.")
                if old_link:
                    print(f"  Old: {old_link}")
                    print(f"  New: {repo_url}")
                shutil.rmtree(source_dir)
                repo = None
            else:
                # Link matches, update existing repo
                try:
                    if repo is None:
                        repo = git.Repo(source_dir)
                    repo.git.reset("--hard")
                    repo.git.clean("-fdx")

                    if commit:
                        # Check if already at the correct commit
                        if repo.head.commit.hexsha.startswith(commit):
                            print(f"Already at commit '{commit[:8]}'.")
                        else:
                            progressive_checkout(repo, commit)
                    else:
                        # Update to latest on branch
                        if str(depth).lower() == "full":
                            print("Performing full fetch (no depth limit)...")
                            if repo.git.rev_parse('--is-shallow-repository') == 'true':
                                repo.git.fetch("--unshallow")
                            else:
                                repo.git.fetch("--all", "--tags", "--prune")
                        else:
                            repo.git.fetch("origin", "--tags", "--depth", str(depth))

                        if branch:
                            repo.git.checkout(branch)
                            repo.git.reset("--hard", f"origin/{branch}")
                            print(f"Checked out and reset branch '{branch}'.")
                        else:
                            # --- SMART FALLBACK ---
                            default_branch = get_default_branch(repo_url)
                            print(f"No branch or commit specified — resetting to '{default_branch}'.")
                            try:
                                repo.git.fetch("origin", default_branch)
                                repo.git.checkout(default_branch)
                                repo.git.reset("--hard", f"origin/{default_branch}")
                                repo.git.clean("-fdx")
                            except Exception:
                                # --- Try common or first valid branch ---
                                fallback_branch = get_first_valid_branch(repo_url)
                                print(f"Default branch '{default_branch}' not found — trying '{fallback_branch}'.")
                                repo.git.fetch("origin", fallback_branch)
                                repo.git.checkout(fallback_branch)
                                repo.git.reset("--hard", f"origin/{fallback_branch}")
                                repo.git.clean("-fdx")

                except Exception as e:
                    print(f"Error updating repo {source}: {e}")
                    if os.path.exists(source_dir):
                        shutil.rmtree(source_dir)
                    repo = None

        # --- Fresh clone if repo doesn't exist or was removed ---
        if not repo:
            try:
                # If commit is specified but no branch, try to find branches containing the commit
                if commit and not branch:
                    branches_with_commit = get_commit_branch(repo_url, commit, source)
                    if branches_with_commit:
                        clone_branch = branches_with_commit[0]
                        print(f"Found commit in branch '{clone_branch}'")
                    else:
                        clone_branch = get_default_branch(repo_url)
                elif not branch:
                    clone_branch = get_default_branch(repo_url)
                else:
                    clone_branch = branch

                if str(depth).lower() == "full":
                    print(f"Cloning {source} (full clone)...")
                    repo = git.Repo.clone_from(repo_url, source_dir, branch=clone_branch)
                    print(f"Cloned '{source}' on branch '{clone_branch}'.")
                else:
                    print(f"Cloning {source} (depth={depth})...")
                    try:
                        repo = git.Repo.clone_from(repo_url, source_dir, branch=clone_branch, depth=int(depth))
                        print(f"Cloned '{source}' on branch '{clone_branch}'.")
                    except git.exc.GitCommandError:
                        fallback_branch = get_first_valid_branch(repo_url)
                        print(f"Branch '{clone_branch}' not found — retrying clone with '{fallback_branch}'.")
                        repo = git.Repo.clone_from(repo_url, source_dir, branch=fallback_branch, depth=int(depth))
                        print(f"Cloned '{source}' on branch '{fallback_branch}'.")

                # Write the link file after successful clone
                os.makedirs(source_dir, exist_ok=True)
                with open(link_file, "w") as lf:
                    lf.write(repo_url)

                if commit:
                    progressive_checkout(repo, commit)

            except Exception as e:
                print(f"Error cloning {source}: {e}")
                continue

        # --- Apply patches ---
        do_patches(details, mss_variant)

        print()  # blank line between repos
        source_directories[source] = source_dir

    return source_directories, mss_variant


# Calls the MSS Configurator and generate an MSS configuration in a directory based on a cfg file
def make_mss_config(mss_configurator, config_file, output_dir):
    """Generate MSS configuration using the MSS Configurator tool.

    Validates that expected output files are created and raises an exception if not.

    Raises:
        Exception: If MSS configuration generation fails or expected files aren't created
    """

    print("================================================================================")
    print("                          Generating MSS configuration")
    print("================================================================================\n", flush=True)

    cmd = f"{mss_configurator} -GENERATE -CONFIGURATION_FILE:{config_file} -OUTPUT_DIR:{output_dir}"

    try:
        exe_sys_cmd(cmd)

        # Validate that expected output files were created
        output_files = (
            glob.glob(os.path.join(output_dir, "*.xml")) +
            glob.glob(os.path.join(output_dir, "*.html")) +
            glob.glob(os.path.join(output_dir, "*.cfg")) +
            glob.glob(os.path.join(output_dir, "*.cxz"))
        )

        if not output_files:
            raise Exception("No MSS configuration files were created")

        print("MSS configuration completed successfully")

    except Exception as e:
        raise Exception(f"MSS configuration failed: {e}")


# Builds the HSS using a pre-defined config file using SoftConsole in headless mode
def make_hss(hss_source, build_options_input_yaml_file, board_options_input_yaml_file=None):
    with open(build_options_input_yaml_file) as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        hss_info = data.get("HSS", {})

    if board_options_input_yaml_file and os.path.exists(board_options_input_yaml_file):
        board_filename = os.path.basename(board_options_input_yaml_file)
        board = os.path.splitext(board_filename)[0]
    else:
        board = "mpfs-beaglev-fire" #default board

    hss_type = hss_info.get('type', 'git')  # Default to 'git' if 'type' is not provided

    selected_hex_file = None  # Initialize selected_hex_file

    if hss_type == 'download':
        print("================================================================================")
        print("                      Using Downloaded Hart Software Services (HSS) Release")
        print("================================================================================\r\n", flush=True)
        
        hss_release_dir = hss_source

        # Dynamically find a hex file
        hex_file_found = False
        selected_hex_file = None

        for root, dirs, files in os.walk(hss_release_dir):
            for file in files:
                if file.endswith('.hex'):  # Dynamically locate any .hex file
                    source_file = os.path.join(root, file)
                    dest_file = os.path.join('work', 'HSS', file)
                    shutil.copyfile(source_file, dest_file)
                    selected_hex_file = os.path.abspath(dest_file)
                    print(f"HSS image copied from {source_file} to {dest_file}")
                    hex_file_found = True
                    break
            if hex_file_found:
                break

        if not hex_file_found:
            print(f"Error: No .hex file found in {hss_release_dir}")
            return None

        print(f"Selected HSS image: {selected_hex_file}")
        return selected_hex_file

    elif hss_type == 'git':
        print("================================================================================")
        print("                      Build Hart Software Services (HSS)")
        print("================================================================================\r\n", flush=True)

        def normalize_dtb_timestamps(folder_path, threshold_ns=100_000_000):
            """
            Finds all .dts/.dtb pairs in the folder and normalizes .dtb timestamps
            to match .dts if they differ by less than threshold_ns nanoseconds.
            Displays time differences in ns or ms depending on magnitude.
            Returns a list of normalized file pairs.
            """
            normalized = []

            # Build a map of .dts files by stem
            dts_files = {
                os.path.splitext(f)[0]: os.path.join(folder_path, f)
                for f in os.listdir(folder_path)
                if f.endswith('.dts')
            }

            # Look for matching .dtb files
            for f in os.listdir(folder_path):
                if f.endswith('.dtb'):
                    stem = os.path.splitext(f)[0]
                    dtb_path = os.path.join(folder_path, f)
                    dts_path = dts_files.get(stem)

                    if dts_path and os.path.isfile(dts_path):
                        try:
                            mtime_dts_ns = os.stat(dts_path).st_mtime_ns
                            mtime_dtb_ns = os.stat(dtb_path).st_mtime_ns
                            diff_ns = abs(mtime_dts_ns - mtime_dtb_ns)

                            # Format difference
                            if diff_ns == 0:
                                diff_str = "no difference"
                            elif diff_ns <= 1000:
                                diff_str = f"{diff_ns}ns"
                            else:
                                diff_str = f"{diff_ns / 1_000_000:.3f}ms"

                            if 0 < diff_ns < threshold_ns:
                                subprocess.run(['touch', '-r', dts_path, dtb_path], check=True)
                                print(f"Normalized: '{dtb_path}' to match '{dts_path}' ({diff_str})")
                                normalized.append((dts_path, dtb_path))
                            else:
                                print(f"Skipped: '{dtb_path}' ({diff_str})")

                        except Exception as e:
                            print(f"Error processing {dtb_path}: {e}")

            return normalized

        print("Board: " + board)

        xml_directory = os.path.join(hss_source, "boards", board, "soc_fpga_design", "xml")

        print(f"Cleaning up existing XML files in {xml_directory}")
        try:
            existing_xml_files = glob.glob(os.path.join(xml_directory, "*.xml"))
            for xml_file in existing_xml_files:
                print(f"Emptying {xml_file}")
                with open(xml_file, 'w') as f:
                    f.truncate(0)
        except OSError as e:
            print(f"Error cleaning up XML files: {e}", flush=True)
            return None

        generated_xml_files = glob.glob(os.path.join("work", "MSS", "*.xml"))
        if not generated_xml_files:
            print("Error: No generated XML files found.")
            return None
        else:
            # Get the single existing XML file that was emptied earlier
            existing_xml_files = glob.glob(os.path.join(xml_directory, "*.xml"))

            if len(existing_xml_files) != 1:
                raise RuntimeError(f"Error: Expected exactly 1 XML file in directory, found {len(existing_xml_files)}")

            target_xml_file = existing_xml_files[0]
            generated_xml_file = generated_xml_files[0]  # Assuming first/only generated file

            try:
                with open(generated_xml_file, 'r') as source:
                    with open(target_xml_file, 'w') as target:
                        target.write(source.read())
                print(f"Copied contents from {generated_xml_file} to existing file {target_xml_file}")
            except IOError as e:
                print(f"Error copying contents: {e}")
                return None

        def_config_file_select = hss_info.get("def_config_examples")  

        if def_config_file_select:
            def_config_file = os.path.join(hss_source, "boards", board, "def_config_examples", def_config_file_select)
            print(f"!!                                                !!", flush=True)
            print(f"Using def_config file: ", def_config_file_select, flush=True)
            print(f"!!                                                !!", flush=True)
        else:
            # Proceed with building the HSS
            def_config_file = os.path.join(hss_source, "boards", board, "def_config")
        try:
            shutil.copyfile(def_config_file, os.path.join(hss_source, "./.config"))
        except IOError as e:
            print(f"Error copying def_config file: {e}", flush=True)
            return None

        initial_directory = os.getcwd()

        verbose = hss_info.get("verbose", False)
        make_clean = hss_info.get("make_clean", False)

        try:
            # Ensure `hss_source` exists and is a directory
            if not os.path.isdir(hss_source):
                raise ValueError(f"The source directory '{hss_source}' does not exist or is not a directory.")

            os.chdir(hss_source)

            normalize_dtb_timestamps(os.path.join("boards", board))

            # Execute the make clean command if specified
            if make_clean:
                clean_command = f"make clean BOARD={board}"
                if verbose:
                    clean_command += " V=1"
                exe_sys_cmd(clean_command)

            # Build command
            build_command = f"make BOARD={board}"
            if verbose:
                build_command += " V=1"
            exe_sys_cmd(build_command)

        except Exception as e:
            print(f"An error occurred: {e}")
            raise
        finally:
            os.chdir(initial_directory)

        # Check if the build was successful and copy the artifact
        if board == 'bvf': # Openbeagle HSS - bvf HSS is outputted to a different folder
            generated_hex_dir = os.path.normpath(os.path.join(hss_source, "Default", "bootmode1"))
        else:
            generated_hex_dir = os.path.normpath(os.path.join(hss_source, "build", "bootmode1"))

        hex_files = glob.glob(os.path.join(generated_hex_dir, "*.hex"))
        if hex_files:
            source_hex_file = os.path.normpath(hex_files[0])
            dest_hex_file = os.path.normpath(os.path.join("work", "HSS", os.path.basename(source_hex_file)))
            shutil.copyfile(source_hex_file, dest_hex_file)
            selected_hex_file = os.path.abspath(dest_hex_file)
            print(f"HSS image copied from {source_hex_file} to {dest_hex_file}")
            return selected_hex_file
        else:
            raise Exception("!!! Error: Hart Soft Service build failed !!!", flush=True)

    else:
        print("Error: Unknown HSS type specified.")
        return None


def get_libero_script_args(build_options_yaml_path, board_options_yaml_path=None):
    libero_script_args = ""

    with open(build_options_yaml_path) as f:
        build_options_data = yaml.load(f, Loader=yaml.FullLoader)
        if build_options_data and build_options_data.get("gateware"):
            libero_script_args = build_options_data["gateware"].get("build-args", "")

    if board_options_yaml_path and os.path.isfile(board_options_yaml_path):
        board_filename = os.path.basename(board_options_yaml_path)
        board = os.path.splitext(board_filename)[0]
        libero_script_args += f" BOARD:{board}"
        try:
            with open(board_options_yaml_path, "r") as f:
                board_options_data = yaml.load(f, Loader=yaml.FullLoader)
                if isinstance(board_options_data, dict):
                    for key, value in board_options_data.items():
                        libero_script_args += f" {key}:{value}"
                else:
                    print(f"Warning: Board options YAML at {board_options_yaml_path} is empty or not a dictionary.")
        except Exception as e:
            print(f"Error reading or parsing board options YAML: {e}")
    else:
        libero_script_args += f" BOARD:mpfs-beaglev-fire"

    if libero_script_args is None:
        libero_script_args = "NONE"
    return libero_script_args


#
# Retrieve/generate the gateware's design version. This version number is stored in the PolarFire SoC device and used
# as part of programming the PolarFire SoC FPGA using IAP (gateware programming from Linux).
# Care must be taken to ensure this version number is different between programming attempts. Otherwise, the PolarFire
# SoC System Controller will not attempt to program the FPGA with the new gateware if it finds the design versions are
# identical.
# The approach to managing design version numbers is to use a unique design version number for release gateware. This
# unique design version number is specified as part of the yaml build option file. The version number is dd.vv.r where
# dd identifies the design, vv is an incremental features identifier and r is a revision number.
# For development, the design version number is generated based on the gateware generation date/time. This generated
# version number loops back every 45 days given the design version number stored in PolarFire SoC is 16 bit long.
#
def get_design_version(source_list):
    version_file = "design_version.yaml"

    # Read previous version from file if it exists
    previous_design_version = None
    previous_source_file = None

    # Parse the previous design version and source file, if available
    if os.path.exists(version_file):
        with open(version_file, "r") as vf:
            try:
                data = yaml.safe_load(vf)
                previous_design_version = data.get("design_version")
                previous_source_file = data.get("source_file")
            except Exception as e:
                print(f"Warning: Could not read {version_file}: {e}")

    with open(source_list) as f:  # open the yaml file passed as an arg
        data = yaml.load(f, Loader=yaml.FullLoader)
        unique_design_version = data.get("gateware").get("unique-design-version")
        f.close()

    source_changed = previous_source_file != source_list

    if unique_design_version is None:
        now = datetime.datetime.now()
        day_of_year = now.timetuple().tm_yday
        design_version = ((day_of_year %45) * 1440) + (now.hour * 60) + now.minute
    else:
        try:
            udv_sl = unique_design_version.split(".")
            if len(udv_sl) != 3:
                raise ValueError("Invalid format")
            design_version = (int(udv_sl[0]) * 1000) + (int(udv_sl[1]) * 10) + int(udv_sl[2])
        except (ValueError, AttributeError):
            print("Error: Invalid value for unique-design-version in ", source_list )
            print("unique-design-version must be in the form dd.vv.r")
            exit()

    # FPGA design version number stored in Polarfire SoC devices is 16 bits long.
    design_version = design_version % 65536

    # Handle version logic based on whether source changed
    if not source_changed:
        print("Same source file used as before, checking design version")
        # Prevent version downgrade
        if previous_design_version is not None and previous_design_version > design_version:
            design_version = previous_design_version

        # Warn if unchanged and handle user input
        if previous_design_version is not None and previous_design_version >= design_version:
            print(f"WARNING: The design version {design_version} is the same as or less than the previously used one ({previous_design_version}).")
            print("WARNING: The gateware will not be updated unless the design version is different.")

            # Use previous_design_version for auto-increment when it exists
            incremented_version = previous_design_version
            prompt = f"Enter new version number (X.Y.Z format), 'n' to keep current version, or <Enter> to auto-increment to ({incremented_version + 1}): "
            response = input(prompt).strip().lower()

            if response == "":
                design_version = (incremented_version + 1) % 65536
                print(f"Auto-incremented version: {design_version}")
            elif response == "n":
                print(f"Keeping existing design version: {design_version}")
            else:
                try:
                    # Check if input is in X.Y.Z format
                    if "." in response:
                        parts = response.split(".")
                        if len(parts) == 3:
                            design_version = (int(parts[0]) * 1000) + (int(parts[1]) * 10) + int(parts[2])
                            design_version = design_version % 65536
                            print(f"Using user-specified version: {design_version}")
                        else:
                            raise ValueError("Invalid X.Y.Z format")
                    else:
                        design_version = int(response) % 65536
                        print(f"Using user-specified version: {design_version}")
                except ValueError:
                    print("Invalid input. Keeping the original design version.")
    else:
        print("Different source file detected")

    # Save current version and source file info
    try:
        with open(version_file, "w") as vf:
            yaml.safe_dump({
                "design_version": design_version,
                "source_file": source_list
            }, vf)
    except Exception as e:
        print(f"Warning: Could not save version file: {e}")

    print("Design version:", design_version)
    return str(design_version)


# The function below assumes the current working directory is the gateware's git repository.
def get_git_hash():
    try:
        git_hash = subprocess.check_output(['git', 'log', "--pretty=format:'%H'", '-n', '1'])
    except subprocess.CalledProcessError as e:
        git_hash = 0
    return git_hash.decode('ascii').strip("'")


# Build the gateware's top level name from the build option directory name and the git hassh of the gateware's
# repository.
def get_top_level_name():
    git_hash = get_git_hash()
    top_level_name = str(os.path.splitext(os.path.basename(build_options_input_yaml_file))[0])
    top_level_name = top_level_name.replace('-', '_')
    top_level_name = top_level_name + '_' + git_hash
    if len(top_level_name) > 30:
        top_level_name = top_level_name[:30]
    top_level_name = top_level_name.upper()
    return top_level_name


# Calls Libero and runs a script
def call_libero(libero, script, script_args, project_location, hss_image_location, mss_component_file_location, prog_export_path, top_level_name, initial_directory, design_version):
    libero_cmd = libero + " SCRIPT:" + script + " \"SCRIPT_ARGS: " + script_args + " PROJECT_LOCATION:" + project_location + " TOP_LEVEL_NAME:" + top_level_name + " HSS_IMAGE_PATH:" + hss_image_location + " PROG_EXPORT_PATH:" + prog_export_path + " MSS_COMPONENT_PATH:" + mss_component_file_location + " INITIAL_DIRECTORY:" + initial_directory + " DESIGN_VERSION:" + design_version + "\""
    exe_sys_cmd(libero_cmd)


def generate_libero_project(libero, build_options_input_yaml_file, board_options_input_yaml_file, fpga_design_sources_path, build_dir_path, design_version):
    print("================================================================================")
    print("                            Generate Libero project")
    print("================================================================================\r\n", flush=True)
    # Execute the Libero TCL script used to create the Libero design
    initial_directory = os.getcwd()
    os.chdir(fpga_design_sources_path)
    project_location = os.path.join("..", "..", build_dir_path, "work", "libero")
    script = "BUILD_BVF_GATEWARE.tcl"

    script_args = get_libero_script_args(build_options_input_yaml_file, board_options_input_yaml_file)

    if script_args == "NONE":
        script_args = ""
    else:
        script_args += " "

    hss_image_location = os.path.join("..", "..", "work", "HSS", "hss-envm-wrapper-bm1-p0.hex")

    mss_dir = os.path.abspath(os.path.join(project_location, "..", "MSS"))
    cxz_files = glob.glob(os.path.join(mss_dir, "*.cxz"))
    if not cxz_files:
        raise FileNotFoundError(f"No .cxz files found in {mss_dir}")
    if len(cxz_files) > 1:
        raise RuntimeError(f"More than one .cxz file found in {mss_dir}: {cxz_files}")

    mss_component_file_location = cxz_files[0]

    prog_export_path = os.path.join("..", "..", build_dir_path)

    top_level_name = get_top_level_name()
    print("top level name: ", top_level_name)

    call_libero(libero, script, script_args, project_location, hss_image_location, mss_component_file_location, prog_export_path, top_level_name, initial_directory, design_version)
    os.chdir(initial_directory)


def build_gateware(build_options_yaml_arg, board_options_yaml_arg, build_dir, gateware_top_dir):
    global libero
    global mss_configurator
    global softconsole_headless
    global programming

    log_file_path = os.path.join("build_log.txt")
    original_stdout = sys.stdout
    sys.stdout = Logger(log_file_path)

    set_arguments(build_options_yaml_arg, board_options_yaml_arg)

    check_tool_status()

    design_version = get_design_version(build_options_yaml_arg)

    sources = {}

    init_workspace()

    (sources, mss_variant) = clone_sources(build_options_input_yaml_file, gateware_top_dir)

    build_options_list = get_libero_script_args(build_options_yaml_arg)

    if build_options_list != 'NONE':
        options = build_options_list.split()

        # Check if SmartHLS tool is in path
        for option in options:
            opt = option.split(':')
            if len(opt) == 2:
                key, value = opt
                if key.startswith('SHLS'):
                    check_shls_tool_status()

    generate_gateware_overlays(os.path.join(gateware_top_dir, "sources", "FPGA-design"),
                               os.path.join(os.getcwd(), "bitstream", "LinuxProgramming"),
                               build_options_list, mss_variant)
    

    die = None
    package = None

    if board_options_yaml_arg and os.path.isfile(board_options_yaml_arg):
        board_filename = os.path.basename(board_options_yaml_arg)
        board = os.path.splitext(board_filename)[0]

        try:
            with open(board_options_yaml_arg, "r") as f:
                board_options = yaml.safe_load(f) or {}
        except Exception as e:
            raise RuntimeError(f"Failed to load board options YAML: {e}")

        for key in board_options:
            if key == "DIE":
                die = board_options[key]
            elif key == "PACKAGE":
                package = board_options[key]

        if not die or not package:
            raise ValueError("DIE or PACKAGE missing from board options YAML")

    else:
        board = "mpfs-beaglev-fire" #default board
        die = "MPFS025T"
        package = "FCVG484"
    
    mss_folder_path = os.path.join(os.getcwd(), "sources", "MSS", "configs",
                                   die, package, board)
    
    print(f"MSS folder path: {mss_folder_path}")
    cfg_files = glob.glob(os.path.join(mss_folder_path, "*.cfg"))

    if cfg_files:
        mss_config_file_path = cfg_files[0]
        print(f"Selected config file: {mss_config_file_path}")
    else:
        print(f"No .cfg file found in {mss_folder_path}")
        sys.exit(1)

    work_mss_dir = os.path.join("work", "MSS")

    try:
        make_mss_config(mss_configurator, mss_config_file_path, os.path.join(os.getcwd(), work_mss_dir))
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

    make_hss(sources["HSS"], build_options_input_yaml_file, board_options_yaml_arg)

    fpga_design_sources_path = os.path.join(gateware_top_dir, "sources", "FPGA-design")
    generate_libero_project(libero, build_options_input_yaml_file, board_options_yaml_arg, fpga_design_sources_path, build_dir, design_version )

    sys.stdout.flush()
    sys.stdout = original_stdout

    print("Finished", flush=True)


def main():
    global libero
    global mss_configurator
    global softconsole_headless
    global programming

    parse_arguments()

    # This function will check if all of the required tools are present and quit if they aren't
    check_tool_status()

    sources = {}

    # Bitstream building starts here - see individual functions for a description of their purpose
    init_workspace()

    (sources, mss_variant) = clone_sources(build_options_input_yaml_file)

    build_options_list = get_libero_script_args(build_options_input_yaml_file, board_options_input_yaml_file)
    generate_gateware_overlays(os.path.join(os.getcwd(), "bitstream", "LinuxProgramming"), build_options_list, mss_variant)

    mss_config_file_path = os.path.join(".", "sources", "MSS_Configuration", "MSS_Configuration.cfg")
    work_mss_dir = os.path.join("work", "MSS")
    make_mss_config(mss_configurator, mss_config_file_path, os.path.join(os.getcwd(), work_mss_dir))

    make_hss(sources["HSS"], build_options_input_yaml_file, board_options_input_yaml_file)

    generate_libero_project(libero, build_options_input_yaml_file, board_options_input_yaml_file)

    print("Finished", flush=True)


if __name__ == '__main__':
    main()
