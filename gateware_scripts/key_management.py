#!/usr/bin/env python3
"""
Boot Mode 3 Key Management - Single Key with Archive

This module manages exactly ONE active public key for Boot Mode 3 secure boot.
Keys are stored on first generation and reused unless explicitly regenerated.
All keys are archived with timestamps for tracking purposes.

Usage:
    from key_management import KeyManager, integrate_with_build

    mgr = KeyManager()
    ucskx, ucsky = integrate_with_build(mgr, hss_key_file, design_name,
                                        design_version, force_new_keys=False)
"""

import os
import shutil
from pathlib import Path
from typing import Tuple, Optional, List
from datetime import datetime
import re
import json


class KeyError(Exception):
    """Key management errors"""
    pass


class KeyManager:
    """Manages a single active Boot Mode 3 public key with archive tracking"""

    def __init__(self, key_store_path: str = "./key_store"):
        """
        Initialize key manager

        Args:
            key_store_path: Directory to store keys and tracking
        """
        self.key_store_path = Path(key_store_path)
        self.key_store_path.mkdir(parents=True, exist_ok=True)

        # Active key files
        self.key_file = self.key_store_path / "current_key.txt"
        self.metadata_file = self.key_store_path / "key_metadata.txt"

        # Archive directory and tracking
        self.archive_dir = self.key_store_path / "archive"
        self.archive_dir.mkdir(exist_ok=True)
        self.tracking_file = self.key_store_path / "key_tracking.json"

        self._load_tracking()

    def _load_tracking(self):
        """Load the key tracking database"""
        if self.tracking_file.exists():
            with open(self.tracking_file, 'r') as f:
                self.tracking = json.load(f)
        else:
            self.tracking = {
                "keys": [],
                "current_key_id": None
            }

    def _save_tracking(self):
        """Save the key tracking database"""
        with open(self.tracking_file, 'w') as f:
            json.dump(self.tracking, f, indent=2)

    def _generate_key_id(self) -> str:
        """Generate a unique key ID based on timestamp"""
        return f"key_{datetime.now().strftime('%Y%m%d_%H%M%S')}"

    def parse_key_file(self, key_file_path: str) -> Tuple[str, str]:
        """
        Parse HSS-generated public key file

        Args:
            key_file_path: Path to hss-envm-wrapper-bm3-public-key-xy.txt

        Returns:
            Tuple of (ucskx, ucsky)
        """
        if not os.path.exists(key_file_path):
            raise KeyError(f"Key file not found: {key_file_path}")

        ucskx = None
        ucsky = None

        with open(key_file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith('ucskx='):
                    ucskx = line.split('=', 1)[1].strip()
                elif line.startswith('ucsky='):
                    ucsky = line.split('=', 1)[1].strip()

        if not ucskx or not ucsky:
            raise KeyError(f"Invalid key file format: {key_file_path}")

        # Validate hex format
        if not re.match(r'^[0-9a-fA-F]+$', ucskx) or not re.match(r'^[0-9a-fA-F]+$', ucsky):
            raise KeyError("Keys contain invalid characters (expected hex)")

        return ucskx, ucsky

    def _archive_current_key(self, reason: str = "Replaced"):
        """Archive the current key before replacing it"""
        if not self.has_key():
            return

        key_id = self.tracking["current_key_id"]
        if not key_id:
            # Current key exists but not in tracking (migration case)
            key_id = self._generate_key_id()

        # Update tracking info for archived key
        for key_info in self.tracking["keys"]:
            if key_info["key_id"] == key_id:
                key_info["archived_at"] = datetime.now().isoformat()
                key_info["archived_reason"] = reason
                key_info["status"] = "archived"
                break

        self._save_tracking()
        print(f"  Archived previous key: {key_id}")

    def store_key(self, key_file_path: str, design_name: str, design_version: int):
        """
        Store the current key (archives previous key if exists)

        Args:
            key_file_path: Path to HSS-generated key file
            design_name: Design name
            design_version: Design version
        """
        # Validate key can be parsed
        ucskx, ucsky = self.parse_key_file(key_file_path)

        # Generate key ID and archive filename
        key_id = self._generate_key_id()
        archive_filename = f"{key_id}.txt"
        archive_path = self.archive_dir / archive_filename

        # Archive current key if it exists
        if self.has_key():
            self._archive_current_key("Replaced by new key generation")

        # Copy to both current location and archive
        shutil.copy2(key_file_path, self.key_file)
        shutil.copy2(key_file_path, archive_path)

        # Write metadata
        with open(self.metadata_file, 'w') as f:
            f.write(f"key_id={key_id}\n")
            f.write(f"design_name={design_name}\n")
            f.write(f"design_version={design_version}\n")
            f.write(f"ucskx={ucskx}\n")
            f.write(f"ucsky={ucsky}\n")
            f.write(f"created_at={datetime.now().isoformat()}\n")

        # Add to tracking
        key_record = {
            "key_id": key_id,
            "design_name": design_name,
            "design_version": design_version,
            "ucskx": ucskx,
            "ucsky": ucsky,
            "created_at": datetime.now().isoformat(),
            "archive_file": str(archive_path),
            "status": "active",
            "archived_at": None,
            "archived_reason": None
        }

        self.tracking["keys"].append(key_record)
        self.tracking["current_key_id"] = key_id
        self._save_tracking()

        print(f"[OK] Stored key: {key_id}")
        print(f"  Design: {design_name} v{design_version}")
        print(f"  Location: {self.key_file}")
        print(f"  Archived: {archive_path}")

    def get_current_key(self) -> Tuple[str, str]:
        """
        Get the current stored key

        Returns:
            Tuple of (ucskx, ucsky)
        """
        if not self.key_file.exists():
            raise KeyError("No key currently stored")

        return self.parse_key_file(str(self.key_file))

    def get_metadata(self) -> dict:
        """
        Get metadata about the current key

        Returns:
            Dictionary with key_id, design_name, design_version, ucskx, ucsky, created_at
        """
        if not self.metadata_file.exists():
            return {}

        metadata = {}
        with open(self.metadata_file, 'r') as f:
            for line in f:
                line = line.strip()
                if '=' in line:
                    key, val = line.split('=', 1)
                    metadata[key] = val

        return metadata

    def export_key(self, output_path: str, key_id: Optional[str] = None) -> Tuple[str, str]:
        """
        Export a key to a file

        Args:
            output_path: Where to write the key
            key_id: Optional key ID to export (default: current key)

        Returns:
            Tuple of (ucskx, ucsky)
        """
        if key_id:
            # Export from archive
            key_record = self.get_key_info(key_id)
            if not key_record:
                raise KeyError(f"Key not found: {key_id}")

            archive_file = key_record["archive_file"]
            if not os.path.exists(archive_file):
                raise KeyError(f"Archive file not found: {archive_file}")

            shutil.copy2(archive_file, output_path)
            print(f"[OK] Exported key {key_id} to {output_path}")
            return key_record["ucskx"], key_record["ucsky"]
        else:
            # Export current key
            if not self.key_file.exists():
                raise KeyError("No key currently stored")

            shutil.copy2(self.key_file, output_path)
            print(f"[OK] Exported current key to {output_path}")
            return self.get_current_key()

    def has_key(self) -> bool:
        """Check if a key is currently stored"""
        return self.key_file.exists()

    def list_all_keys(self) -> List[dict]:
        """
        List all tracked keys

        Returns:
            List of key records
        """
        return self.tracking["keys"]

    def get_key_info(self, key_id: str) -> Optional[dict]:
        """
        Get information about a specific key

        Args:
            key_id: Key ID to look up

        Returns:
            Key record dictionary or None if not found
        """
        for key_record in self.tracking["keys"]:
            if key_record["key_id"] == key_id:
                return key_record
        return None

    def get_current_key_info(self) -> Optional[dict]:
        """Get information about the current active key"""
        current_id = self.tracking["current_key_id"]
        if not current_id:
            return None
        return self.get_key_info(current_id)

    def reuse_existing_key(self, hss_key_destination: str) -> bool:
        """
        Copy stored key to HSS build location for reuse

        Args:
            hss_key_destination: Where HSS expects to find the key file

        Returns:
            True if key was successfully copied, False if no stored key exists
        """
        if not self.has_key():
            return False

        try:
            shutil.copy2(self.key_file, hss_key_destination)
            metadata = self.get_metadata()
            print(f"[OK] Reusing existing key: {metadata.get('key_id', 'unknown')}")
            print(f"  Original design: {metadata.get('design_name', 'unknown')}")
            print(f"  Created: {metadata.get('created_at', 'unknown')}")
            return True
        except Exception as e:
            print(f"Warning: Failed to copy existing key: {e}")
            return False

    def restore_key(self, key_id: str):
        """
        Restore an archived key as the current active key

        Args:
            key_id: Key ID to restore
        """
        key_record = self.get_key_info(key_id)
        if not key_record:
            raise KeyError(f"Key not found: {key_id}")

        archive_file = key_record["archive_file"]
        if not os.path.exists(archive_file):
            raise KeyError(f"Archive file not found: {archive_file}")

        # Archive current key if exists
        if self.has_key():
            self._archive_current_key("Replaced by restore operation")

        # Copy from archive to current
        shutil.copy2(archive_file, self.key_file)

        # Update metadata
        with open(self.metadata_file, 'w') as f:
            f.write(f"key_id={key_record['key_id']}\n")
            f.write(f"design_name={key_record['design_name']}\n")
            f.write(f"design_version={key_record['design_version']}\n")
            f.write(f"ucskx={key_record['ucskx']}\n")
            f.write(f"ucsky={key_record['ucsky']}\n")
            f.write(f"created_at={key_record['created_at']}\n")
            f.write(f"restored_at={datetime.now().isoformat()}\n")

        # Update tracking
        key_record["status"] = "active"
        key_record["restored_at"] = datetime.now().isoformat()
        self.tracking["current_key_id"] = key_id
        self._save_tracking()

        print(f"[OK] Restored key: {key_id}")
        print(f"  Original design: {key_record['design_name']} v{key_record['design_version']}")


def integrate_with_build(
    manager: KeyManager,
    hss_key_file_path: str,
    design_name: str,
    design_version: int,
    force_new_keys: bool = False
) -> Tuple[str, str]:
    """
    Integration function for the build script

    This handles the key management logic:
    - If keys exist and force_new_keys=False: reuse existing keys
    - If no keys exist OR force_new_keys=True: store newly generated keys

    Args:
        manager: KeyManager instance
        hss_key_file_path: Path to HSS-generated key file
        design_name: Design name
        design_version: Design version number
        force_new_keys: If True, generate and store new keys (default: False)

    Returns:
        Tuple of (ucskx, ucsky)
    """
    print("\n" + "="*80)
    print("Boot Mode 3: Key Management".center(80))
    print("="*80 + "\n")

    if manager.has_key() and not force_new_keys:
        # Reuse existing key
        print("Existing keys found - reusing stored keys")
        print("(Use 'new-bm3-keys: true' in YAML to regenerate)")
        ucskx, ucsky = manager.get_current_key()
        metadata = manager.get_metadata()
        print(f"  Key ID: {metadata.get('key_id', 'unknown')}")
        print(f"  Original design: {metadata.get('design_name', 'unknown')} v{metadata.get('design_version', 'unknown')}")
        print(f"  Created: {metadata.get('created_at', 'unknown')}")

        # Show tracking summary
        all_keys = manager.list_all_keys()
        active_keys = [k for k in all_keys if k['status'] == 'active']
        archived_keys = [k for k in all_keys if k['status'] == 'archived']
        print(f"  Total keys tracked: {len(all_keys)} ({len(active_keys)} active, {len(archived_keys)} archived)")
    else:
        if force_new_keys:
            print("Generating NEW keys (new-bm3-keys: true)")
        else:
            print("No existing keys found - storing newly generated keys")

        # Store the newly generated key
        manager.store_key(hss_key_file_path, design_name, design_version)
        ucskx, ucsky = manager.get_current_key()

        # Show tracking summary
        all_keys = manager.list_all_keys()
        print(f"  Total keys tracked: {len(all_keys)}")

    print(f"\n  Public Key X: {ucskx[:8]}...")
    print(f"  Public Key Y: {ucsky[:8]}...\n")

    return ucskx, ucsky


# CLI Interface
def main():
    """Command-line interface for key management"""
    import sys

    if len(sys.argv) < 2:
        print("Usage:")
        print("  python key_management.py show                - Show current key")
        print("  python key_management.py list                - List all tracked keys")
        print("  python key_management.py info <key_id>       - Show key details")
        print("  python key_management.py export <path>       - Export current key")
        print("  python key_management.py export <key_id> <path> - Export specific key")
        print("  python key_management.py restore <key_id>    - Restore archived key")
        return

    cmd = sys.argv[1]
    mgr = KeyManager()

    if cmd == 'show':
        if not mgr.has_key():
            print("No key currently stored")
            return

        metadata = mgr.get_metadata()
        print("\nCurrent Active Key:")
        print("="*70)
        print(f"Key ID:       {metadata.get('key_id', 'unknown')}")
        print(f"Design:       {metadata.get('design_name', 'unknown')}")
        print(f"Version:      {metadata.get('design_version', 'unknown')}")
        print(f"Created:      {metadata.get('created_at', 'unknown')}")
        print(f"Public Key X: {metadata.get('ucskx', '')[:64]}...")
        print(f"Public Key Y: {metadata.get('ucsky', '')[:64]}...")
        print(f"\nStored at:    {mgr.key_file}")

    elif cmd == 'list':
        all_keys = mgr.list_all_keys()
        if not all_keys:
            print("No keys tracked")
            return

        current_id = mgr.tracking["current_key_id"]
        print(f"\nAll Tracked Keys: ({len(all_keys)} total)")
        print("="*70)
        print(f"{'Key ID':<25} {'Status':<10} {'Design':<20} {'Created':<15}")
        print("-"*70)

        for key in all_keys:
            marker = "->" if key["key_id"] == current_id else "  "
            status = key["status"]
            design = f"{key['design_name']} v{key['design_version']}"
            created = key['created_at'].split('T')[0] if 'T' in key['created_at'] else key['created_at'][:10]
            print(f"{marker} {key['key_id']:<23} {status:<10} {design:<20} {created:<15}")

        print("\n-> = Currently active key")
        print(f"Archive location: {mgr.archive_dir}")

    elif cmd == 'info':
        if len(sys.argv) < 3:
            print("Usage: python key_management.py info <key_id>")
            return

        key_id = sys.argv[2]
        key_info = mgr.get_key_info(key_id)

        if not key_info:
            print(f"Key not found: {key_id}")
            return

        print(f"\nKey Details:")
        print("="*70)
        print(f"Key ID:         {key_info['key_id']}")
        print(f"Status:         {key_info['status']}")
        print(f"Design:         {key_info['design_name']} v{key_info['design_version']}")
        print(f"Created:        {key_info['created_at']}")
        if key_info.get('archived_at'):
            print(f"Archived:       {key_info['archived_at']}")
            print(f"Archive Reason: {key_info['archived_reason']}")
        if key_info.get('restored_at'):
            print(f"Restored:       {key_info['restored_at']}")
        print(f"\nPublic Key X:   {key_info['ucskx'][:64]}...")
        print(f"Public Key Y:   {key_info['ucsky'][:64]}...")
        print(f"\nArchive File:   {key_info['archive_file']}")

    elif cmd == 'export':
        if len(sys.argv) == 3:
            # Export current key
            output = sys.argv[2]
            mgr.export_key(output)
        elif len(sys.argv) == 4:
            # Export specific key
            key_id = sys.argv[2]
            output = sys.argv[3]
            mgr.export_key(output, key_id)
        else:
            print("Usage: python key_management.py export <path>")
            print("   or: python key_management.py export <key_id> <path>")

    elif cmd == 'restore':
        if len(sys.argv) < 3:
            print("Usage: python key_management.py restore <key_id>")
            return

        key_id = sys.argv[2]
        mgr.restore_key(key_id)

    else:
        print(f"Unknown command: {cmd}")


if __name__ == '__main__':
    main()