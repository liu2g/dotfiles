#!/bin/sh
if ! gpu_temp=$(nvidia-smi --format=nounits,csv,noheader --query-gpu=temperature.gpu | xargs echo); then
    gpu_temp="??"
fi
if ! gpu_util=$(nvidia-smi --format=nounits,csv,noheader --query-gpu=utilization.gpu | xargs echo); then
    gpu_util="??"
fi
echo "  $gpu_temp°C / $gpu_util%"
