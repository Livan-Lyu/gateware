# Boot Mode 3 Key Management System

A simple yet comprehensive key management system for BeagleV Fire Boot Mode 3 secure boot. This system manages HSS-generated public keys with automatic archiving and tracking.

## Overview

Boot Mode 3 requires ECDSA NIST P-384 public keys for secure boot verification. The HSS build process generates these keys automatically using the `mpfsBootmodeProgrammer` tool. This management system:

- **Stores keys on first generation** - Keys are automatically saved the first time BM3 is built
- **Reuses keys by default** - Subsequent builds use the same keys to maintain secure boot chain
- **Archives all keys** - Every key is preserved with metadata and tracking
- **Explicit regeneration** - New keys only generated when explicitly requested

### Key Generation Process

The HSS build with Boot Mode 3 automatically runs `mpfsBootmodeProgrammer` which:

1. Generates ECDSA NIST P-384 key pair
2. Creates Secure Boot Image Certificate (SBIC)
3. Produces the public key file: `hss-envm-wrapper-bm3-public-key-xy.txt`
4. Embeds the keys in the HSS image

The key management system intercepts this generated key file and manages it for reuse across builds.

### How Key Reuse Works

**Important**: The `mpfsBootmodeProgrammer` tool **always generates new keys** during the HSS Boot Mode 3 build process. The key management system handles key reuse by:

1. **First Build**: Captures the newly generated key and stores it
2. **Subsequent Builds**:
   - Checks if a stored key exists
   - If yes (and `new-bm3-keys: false`): Uses the stored key, ignores HSS-generated key
   - If no (or `new-bm3-keys: true`): Captures and stores the HSS-generated key

This means you'll always see `"Generating ECDSA NIST P-384 keys..."` in the HSS build log, but those keys are only used when explicitly requested or on first build.

## Key Storage Structure

```
key_store/
├── current_key.txt          # Currently active key
├── key_metadata.txt         # Active key metadata
├── key_tracking.json        # Complete key history database
└── archive/
    ├── key_20251106_120000.txt
    ├── key_20251106_143000.txt
    └── key_20251106_160000.txt
```

### HSS Build Output

During Boot Mode 3 builds, you'll see output like:

```
22:59:11 INFO  - mpfsBootmodeProgrammer v3.7 started.
22:59:11 INFO  - Selected boot mode "3 - factory secure boot from eNVM"
22:59:11 INFO  - Generating BIN file...
22:59:11 INFO  - Generating SBIC (Secure Boot Image Certificate)...
22:59:11 INFO  - Generating ECDSA NIST P-384 keys...
22:59:11 INFO  - Generating HEX file...
22:59:17 INFO  - mpfsBootmodeProgrammer completed successfully.
```

Then the key management system takes over:

```
Public key file copied from sources/HSS/build/bootmode3/hss-envm-wrapper-bm3-public-key-xy.txt
                        to key_store/current_key.txt
```

## Basic Workflow

### First Build (Bootmode 3)

```bash
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml
```

Output:
```
Boot Mode 3: Key Management
======================================================================
No existing keys found - storing newly generated keys
  Key ID: key_20251106_120000
  Design: DEFAULT_BM3_E50A515B320F571E18
  Total keys tracked: 1

  Public Key X: a1b2c3d4...
  Public Key Y: 9f8e7d6c...
======================================================================
```

### Subsequent Builds

Keys are automatically reused:

```bash
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml
```

Output:
```
Boot Mode 3: Key Management
======================================================================
Existing keys found - reusing stored keys
(Use 'new-bm3-keys: true' in YAML to regenerate)
  Key ID: key_20251106_120000
  Original design: DEFAULT_BM3_E50A515B320F571E18
  Created: 2025-11-06T12:00:00
  Total keys tracked: 1 (1 active, 0 archived)

  Public Key X: a1b2c3d4...
  Public Key Y: 9f8e7d6c...
======================================================================
```

### Generating New Keys

To generate new keys, add to your build options YAML (e.g., `default-bm3.yaml`):

```yaml
HSS:
  bootmode: 3
  new-bm3-keys: 1  # Force generation of new keys
```

Then build:

```bash
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml
```

The previous key is automatically archived and a new one becomes active.

## Command Line Interface

### Show Current Active Key

```bash
python3 gateware_scripts/key_management.py show
```

Example output:
```
Current Active Key:
======================================================================
Key ID:       key_20251106_143000
Design:       DEFAULT_BM3_E50A515B320F571E18
Version:      2
Created:      2025-11-06T14:30:00
Public Key X: g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2g3h4i5j6k7l8...
Public Key Y: m9n0o1p2q3r4s5t6u7v8w9x0y1z2a3b4c5d6e7f8g9h0i1j2k3l4m5n6o7p8q9r0...

Stored at:    key_store/current_key.txt
```

### List All Tracked Keys

```bash
python3 gateware_scripts/key_management.py list
```

Example output:
```
All Tracked Keys: (5 total)
======================================================================
Key ID                    Status     Design               Created
----------------------------------------------------------------------
  key_20251106_225708     archived   DEFAULT_BM3_E50A515B320F571E18 v3045 2025-11-06
  key_20251106_225917     archived   DEFAULT_BM3_E50A515B320F571E18 v3047 2025-11-06
  key_20251107_012232     archived   DEFAULT_BM3_D8C39240B60B44333C v3035 2025-11-07
  key_20251107_012333     archived   DEFAULT_BM3_D8C39240B60B44333C v3036 2025-11-07
→ key_20251107_012422     active     DEFAULT_BM3_D8C39240B60B44333C v3037 2025-11-07

→ = Currently active key
Archive location: key_store/archive
```

### Show Details for Specific Key

```bash
python3 gateware_scripts/key_management.py info key_20251106_225708
```

Example output:
```
Key Details:
======================================================================
Key ID:         key_20251106_225708
Status:         archived
Design:         DEFAULT_BM3_E50A515B320F571E18 v3045
Created:        2025-11-06T22:57:08.450816
Archived:       2025-11-06T22:59:17.176215
Archive Reason: Replaced by new key generation

Public Key X:   7dd8a9fd7f917c256cf2a291b01951ab7aa6449079e5c73ea3b11fd1893c5e37...
Public Key Y:   e59b90b135475b649721a8676c5ddd349beca6a1ba9f4f517c3120680155c5cd...

Archive File:   key_store/archive/key_20251106_225708.txt
```

### Export Keys

Export current active key:
```bash
python3 gateware_scripts/key_management.py export my_key.txt
```

Export specific archived key:
```bash
python3 gateware_scripts/key_management.py export key_20251106_120000 old_key.txt
```

### Restore Archived Key

To revert to a previous key:

```bash
python3 gateware_scripts/key_management.py restore key_20251107_012232
```

Output:
```
  Archived previous key: key_20251107_012422
✓ Restored key: key_20251107_012232
  Original design: DEFAULT_BM3_D8C39240B60B44333C v3035
```

The restored key becomes active and will be used for all subsequent builds.

## Key Tracking Database

All keys are tracked in `key_store/key_tracking.json`:

```json
{
  "keys": [
    {
      "key_id": "key_20251106_120000",
      "design_name": "DEFAULT_BM3_E50A515B320F571E18",
      "design_version": 1,
      "ucskx": "a1b2c3d4e5f6g7h8...",
      "ucsky": "9f8e7d6c5b4a3b2c...",
      "created_at": "2025-11-06T12:00:00.123456",
      "status": "archived",
      "archived_at": "2025-11-06T14:30:00.654321",
      "archived_reason": "Replaced by new key generation",
      "archive_file": "./key_store/archive/key_20251106_120000.txt"
    },
    {
      "key_id": "key_20251106_143000",
      "design_name": "DEFAULT_BM3_E50A515B320F571E18",
      "design_version": 2,
      "ucskx": "g7h8i9j0k1l2m3n4...",
      "ucsky": "m9n0o1p2q3r4s5t6...",
      "created_at": "2025-11-06T14:30:00.654321",
      "status": "active",
      "archived_at": null,
      "archived_reason": null,
      "archive_file": "./key_store/archive/key_20251106_143000.txt"
    }
  ],
  "current_key_id": "key_20251106_143000"
}
```

## Use Cases

### Production Deployment

1. **First production build** - Keys generated and stored
2. **All subsequent builds** - Same keys reused automatically
3. **Devices programmed** - All devices have matching keys
4. **Firmware updates** - Same keys used for signing

### Development Workflow

```bash
# Normal development - reuses keys
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml

# Testing key rotation - generate new keys
# Edit build options YAML: new-bm3-keys: true
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml

# Revert to previous keys if needed
python3 gateware_scripts/key_management.py list
python3 gateware_scripts/key_management.py restore key_20251106_120000
```

## Troubleshooting

### "No key currently stored" on first build

This is normal. The system will automatically generate and store keys during the first Boot Mode 3 build.

The HSS build process (`mpfsBootmodeProgrammer`) generates fresh P-384 keys on every build by default. The key management system captures and stores these keys on first use, then reuses them for all subsequent builds by copying the stored key back to the expected location before the HSS build runs.

### Keys generated but not used

Check that:
1. `bootmode: 3` is set in your YAML
2. Build completed successfully
3. HSS build generated the key file
4. Key file was found in the expected location

### Want to start fresh

```bash
# Remove all keys and tracking
rm -rf key_store/

# Next build will generate new keys
python3 build-bitstream.py ./build-options/extras/default-bm3.yaml
```

### Accidentally generated new keys

```bash
# Find the previous key
python3 gateware_scripts/key_management.py list

# Restore it
python3 gateware_scripts/key_management.py restore key_YYYYMMDD_HHMMSS
```

## Integration with Build System

The key management system integrates automatically with the build process:

```python
# In build_gateware.py
from gateware_scripts.key_management import KeyManager, integrate_with_build

# Initialize manager
key_manager = KeyManager(key_store_path="./key_store")

# In make_hss() - handles key reuse/generation
ucskx, ucsky = integrate_with_build(
    manager=key_manager,
    hss_key_file_path=dest_key_file,
    design_name=top_level_name,
    design_version=design_version,
    force_new_keys=force_new_keys  # From YAML
)
```

No additional steps needed.

## File Formats

### Key File Format (HSS/mpfsBootmodeProgrammer-generated)

The file `hss-envm-wrapper-bm3-public-key-xy.txt` contains the P-384 public key coordinates:

```
ucskx=a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2g3h4i5j6k7l8m9n0o1p2q3r4s5t6u7v8
ucsky=9f8e7d6c5b4a3b2c1d0e9f8g7h6i5j4k3l2m1n0o9p8q7r6s5t4u3v2w1x0y9z8a7b6c5d4e3f2g1h0i9j8k7l6m5n4o3p2
```

Note: P-384 keys are 96 characters (384 bits) in hexadecimal format.

### Metadata File Format

```
key_id=key_20251106_143000
design_name=DEFAULT_BM3_E50A515B320F571E18
design_version=2
ucskx=a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2
ucsky=9f8e7d6c5b4a3b2c1d0e9f8g7h6i5j4k3l2m1n0o9p8q7r6s5t4u3v2w1x0y9z8
created_at=2025-11-06T14:30:00.654321
```

## Summary

This key management system provides:

- **Automatic key persistence** - Keys stored on first use
- **Safe by default** - Reuses keys unless explicitly told otherwise
- **Complete tracking** - Every key archived with full metadata
- **Easy recovery** - Restore any previous key at any time
- **Simple CLI** - Intuitive commands for key operations
- **Build integration** - Works seamlessly with existing build process
- **Production ready** - Designed for secure boot workflows
