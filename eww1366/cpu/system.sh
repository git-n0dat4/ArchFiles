#!/bin/bash

mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
mem_used=$((mem_total - mem_available))
mem_percent=$((mem_used * 100 / mem_total))

# Mostrar resultados
if [[ "$1" == --ram ]]; then
    echo "$mem_percent"
fi
