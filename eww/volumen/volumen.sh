#!/bin/bash

# Comprobamos la opción proporcionada en "$1"
if [[ "$1" == --get_vol ]]; then
    if pamixer --get-mute | grep -q true; then
        echo "0"
    else
       echo "$(pamixer --get-volume)"
fi

elif [[ "$1" == --get_icon ]]; then
    # Obtener el estado del volumen y mostrar el ícono adecuado
    if pamixer --get-mute | grep -q true || [[ $(pamixer --get-volume) -eq 0 ]]; then
        echo ""  # Icono de mute
    else
        volume=$(pamixer --get-volume)
        if [[ "$volume" -gt 50 ]]; then
            echo ""  # Icono para más de 50%
        else
            echo ""  # Icono para menos de 50%
        fi
    fi

elif [[ "$1" == --up ]]; then
    # Subir el volumen en un 5%
    pamixer -i 5

elif [[ "$1" == --down ]]; then
    # Bajar el volumen en un 5%
    pamixer -d 5

elif [[ "$1" == --toggle-mute ]]; then
    # Alternar entre mute y unmute automáticamente
    pamixer --toggle-mute

else
    # Mostrar ayuda si no se proporciona un argumento válido
    echo "Uso: $0 [--get_vol | --get_icon | --up | --down | --toggle-mute]"
fi
