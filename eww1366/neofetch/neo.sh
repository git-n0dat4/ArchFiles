#!/bin/bash

case "$1" in
    --system)
        echo "󰣇 n0dat4's System"
        ;;
    --devOps)
        echo "n0dat4@devOps"
        ;;
    --user)
        echo " n0dat4"
        ;;
    --os)
        echo "  ArchLinux"
        ;;
    --shell)
        zsh_ver=$(zsh --version 2>/dev/null | awk '{print $2}' | cut -d. -f1,2)
        echo "󰆍  zsh ${zsh_ver:-'No encontrado'}"
        ;;
    --cpu)
        cpu_model=$(lscpu | grep "Model name:" | sed 's/Model name:[[:space:]]*//' | sed 's/ *CPU @.*//')
        cpu_model=$(echo "$cpu_model" | sed 's/(R)//g;s/Core(TM)//g;s/  */ /g')
        threads=$(lscpu | grep "Thread(s) per core:" | awk '{print $4}')
        cpu_mhz=$(lscpu | grep "CPU MHz:" | awk '{print $3}')
        cpu_ghz=$(awk "BEGIN {printf \"%.3f\", $cpu_mhz/1000}")
        echo "󰹑  $cpu_model ($threads) @ ${cpu_ghz}GHz"
        ;;
    --gpu)
        gpu_info=$(lspci | grep -i "VGA" | grep -i "VMware SVGA II Adapter")
        pci_id=$(echo "$gpu_info" | awk '{print $1}')
        gpu_name=$(echo "$gpu_info" | cut -d: -f3- | sed 's/^[ \t]*//')
        echo "󰍛  ${pci_id:-'No encontrado'} ${gpu_name:-'No encontrado'}"
        ;;
    *)
        echo "Uso: $0 [--system | --devOps | --user | --os | --shell | --cpu | --gpu]"
        ;;
esac
