#!/usr/bin/env python3
import json
from pathlib import Path
import shutil

file_path = Path(__file__).resolve()
with open(str(file_path.parents[2] / "meta.json")) as f:
    config_dict = json.load(f)

linked_config_path = Path.home() / config_dict["config_path"] / "ranger" 
real_config_path = file_path.parents[0]

try:
    linked_config_path.unlink(missing_ok=True)
except IsADirectoryError:
    shutil.move(str(linked_config_path), str(linked_config_path)+".old")

linked_config_path.symlink_to(real_config_path,
        target_is_directory=True)

custom_scripts = ["dragon-cp.sh", "dragon-dl.sh", "dragon-mv.sh"]
for s in custom_scripts:
    linked_script_path = Path.home() / config_dict["bin_path"] / s
    real_script_path = file_path.parents[0] / s

    linked_script_path.unlink(missing_ok=True)

    linked_script_path.symlink_to(real_script_path)
