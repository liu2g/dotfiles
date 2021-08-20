#!/usr/bin/env python3
import json
from pathlib import Path

file_path = Path(__file__).resolve()
with open(str(file_path.parents[2] / "meta.json")) as f:
    config_dict = json.load(f)

linked_bin_path = Path.home() / config_dict["bin_path"] / "logout.sh" 
real_bin_path = file_path.parents[0] / "logout.sh"

linked_bin_path.symlink_to(real_bin_path, target_is_directory=True)
