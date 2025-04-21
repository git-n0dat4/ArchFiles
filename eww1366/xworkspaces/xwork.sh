#!/bin/bash

# Define un arreglo asociativo para mapear las opciones a los workspaces
declare -A workspaces=(
    ["--get1"]="󰲠"
    ["--get2"]="󰲢"
    ["--get3"]="󰲤"
    ["--get4"]="󰲦"
    ["--get5"]="󰲨"
)

# Verifica si la opción proporcionada está en el arreglo
if [ -n "${workspaces[$1]}" ]; then
    # Consulta el workspace activo
    active_workspace=$(bspc query -D -d .active --names)
    
    # Si el workspace activo corresponde al workspace del icono recibido
    if [ "$active_workspace" == "${workspaces[$1]}" ]; then
        echo "#bf616a"
    elif [ -n "$(bspc query -N -d "${workspaces[$1]}")" ]; then
        echo "#81a1c1"
    else
        echo "#ffffff"
    fi
fi
