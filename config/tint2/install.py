#!/usr/bin/env python3
import sys
from pathlib import Path
sys.path.append("../../")
from dotinstall import install_config

install_config(Path(__file__).parent, dry_run=True)
input("Press Enter to continue...")
install_config(Path(__file__).parent)