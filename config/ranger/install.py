#!/usr/bin/env python3
import sys
from pathlib import Path
sys.path.append("../../")
from dotinstall import install_config, install_script

install_config(Path(__file__).parent, dry_run=True)
install_script(Path(__file__).parent / "dragon-cp.sh", dry_run=True)
install_script(Path(__file__).parent / "dragon-dl.sh", dry_run=True)
install_script(Path(__file__).parent / "dragon-mv.sh", dry_run=True)
input("Press Enter to execute...")
install_config(Path(__file__).parent)
install_script(Path(__file__).parent / "dragon-cp.sh")
install_script(Path(__file__).parent / "dragon-dl.sh")
install_script(Path(__file__).parent / "dragon-mv.sh")