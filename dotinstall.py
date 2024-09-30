#!/usr/bin/env python3
from pathlib import Path
import shutil
from os import PathLike

default_config_rootdir = Path.home() / ".config"
default_script_rootdir = Path.home() / ".local/bin"

def _install(file_path: PathLike, rootdir: PathLike, dry_run: bool = False):
    rootdir = Path(rootdir)
    if not rootdir.is_dir():
        raise ValueError(f"Root directory {rootdir} does not exist.")
    real_config_path = Path(file_path).resolve()
    if not real_config_path.exists():
        raise ValueError(f"Path at {real_config_path} does not exist.")
    linked_config_path = rootdir / real_config_path.name
    if dry_run:
        print(f"==> Install {real_config_path} to {linked_config_path}")
    if linked_config_path.is_symlink():
        if dry_run:
            print(f" -> Remove existing symlink {linked_config_path} -> {linked_config_path.resolve()}")
        else:
            linked_config_path.unlink()
    elif linked_config_path.exists():
        if dry_run:
            print(f" -> Move existing file {linked_config_path} to {linked_config_path}.old")
        else:
            shutil.move(str(linked_config_path), str(linked_config_path)+".old")
    if dry_run:
        print(f" -> Create symlink {linked_config_path} -> {real_config_path}")
    else:
        linked_config_path.symlink_to(real_config_path, target_is_directory=real_config_path.is_dir())

def install_config(file_path: PathLike, rootdir: PathLike = default_config_rootdir, dry_run: bool = False):
    _install(file_path, rootdir, dry_run)

def install_script(file_path: PathLike, rootdir: PathLike = default_script_rootdir, dry_run: bool = False):
    _install(file_path, rootdir, dry_run)