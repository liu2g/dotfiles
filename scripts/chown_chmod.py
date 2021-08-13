#!/usr/bin/env python3

# Python program to explain shutil.chown() method  
    
import shutil 
from pathlib import Path
  
TARGET_MODE_FILE = 0o664
TARGET_MODE_FOLD = 0o775 # directory needs to be executable to be opened
TARGET_USER = 'liu'
TARGET_GROUP = 'rslsync'

# Path 
base_path = Path('/home/liu/Zufiles/')

for p in base_path.rglob('*'):
    p = p.resolve()
    # print(p, oct(p.stat().st_mode))
    
    if p.is_dir():
        if p.stat().st_mode & 0o777 != TARGET_MODE_FOLD: # bitwise AND masks the LS 3 oct digits
            p.chmod(TARGET_MODE_FOLD)
    elif p.is_file():
        if p.stat().st_mode & 0o777 != TARGET_MODE_FILE:
            p.chmod(TARGET_MODE_FILE)
    if p.owner() != TARGET_USER or p.group() != TARGET_GROUP:
        shutil.chown(str(p), TARGET_USER, TARGET_GROUP)


# Then have the following line in `sudo crontab -e`
# */5 * * * * chown_chmod.py