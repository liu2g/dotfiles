#!/usr/bin/env python3
import sys
from pathlib import Path
sys.path.append("../../")
from dotinstall import install_config

install_config(Path(__file__).parent, dry_run=True)
install_config(Path(__file__).parent / ".zshrc", rootdir=Path.home(), dry_run=True)
input("Press Enter to execute...")
install_config(Path(__file__).parent)
install_config(Path(__file__).parent / ".zshrc", rootdir=Path.home())
