#!/usr/bin/env python3

import json
import subprocess

output = subprocess.check_output([
    "rocm-smi",
    "--showuse",
    "--showmemuse",
    "--showtemp",
    "--json"
])
data = json.loads(output)
gpu_util = data.get("card0", {}).get("GPU use (%)", 0)
mem_util = data.get("card0", {}).get("GPU Memory Allocated (VRAM%)", 0)
temp = data.get("card0", {}).get("Temperature (Sensor edge) (C)", 0)
print(f"󰍹 {temp}°C | {gpu_util}% UTIL | {mem_util}% MEM")
