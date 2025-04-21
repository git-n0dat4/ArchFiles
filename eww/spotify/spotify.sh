#!/bin/bash
temp_file="/home/n0dat4/.config/eww/spotify/spotify_metadata.tmp"

# Función para actualizar la metadata y descargar la carátula
update_metadata() {
    #metadata=$(playerctl metadata --format "{{artist}}\\n{{title}}")
    #echo "$metadata" > "$temp_file"

    artist=$(playerctl metadata --format "{{artist}}")
    title=$(playerctl metadata --format "{{title}}")

    echo "[\"$artist\", \"$title\"]" > "$temp_file"

    #art_url=$(playerctl metadata --format "{{mpris:artUrl}}")

    #if [ -n "$art_url" ]; then
        #curl -s -o "/home/n0dat4/.config/eww/spotify/port.png" "$art_url"
    #else
        #echo "No se encontró URL para la carátula"
    #fi
}

# Variable para guardar el estado actual de la reproducción
prev_metadata=""

while true; do
    current_metadata=$(playerctl metadata --format "{{artist}} - {{title}}")
    
    # Comprobar si la metadata ha cambiado
    if [ "$current_metadata" != "$prev_metadata" ]; then
        update_metadata
        prev_metadata="$current_metadata"
    fi
    sleep 1
done
