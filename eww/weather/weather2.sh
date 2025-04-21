#!/bin/bash

data=$(curl -s "https://wttr.in/Lima?format=j1")

if [ $? -ne 0 ]; then
    echo "Error fetching weather data."
    exit 1
fi

location=$(echo "$data" | jq -r '.nearest_area[0].region[0].value')
detail=$(echo "$data" | jq -r '.current_condition[0].weatherDesc[0].value')
C=$(echo "$data" | jq -r '.current_condition[0].temp_C')
winddir=$(echo "$data" | jq -r '.current_condition[0].winddir16Point')
windspeed=$(echo "$data" | jq -r '.current_condition[0].windspeedKmph')

# Agregar determinación de día o noche
local_time=$(echo "$data" | jq -r '.current_condition[0].localObsDateTime')
# Convertir la hora usando la información de localObsDateTime (asegúrate de que el formato sea compatible con "date")
obs_hour=$(date -d "$local_time" +"%H")
if [ "$obs_hour" -ge 6 ] && [ "$obs_hour" -lt 18 ]; then
    period="day"
else
    period="night"
fi

case "$winddir" in
    N) wind_icon="󰁍";;
    NNE|NE|ENE) wind_icon="󰁝";;
    E) wind_icon="󰁔";;
    ESE|SE|SSE) wind_icon="󰁅";;
    S) wind_icon="󰁂";;
    SSW|SW|WSW) wind_icon="󰁃";;
    W) wind_icon="󰁛";;
    WNW|NW|NNW) wind_icon="󰁜";;
    *) wind_icon="?";; # Default icon if no match
esac

case "$detail" in
    "Sunny")
        if [ "$period" = "day" ]; then
            icon="󰖙"
            message="The sun is shining brightly."
        else
            icon=""  # Icono para noche despejada (puedes modificarlo según tu preferencia)
            message="Clear night sky with stars."
        fi
        ;;
    "Clear")
        if [ "$period" = "day" ]; then
            icon="󰖐"
            message="The sky is clear and peaceful."
        else
            icon=""
            message="Clear night sky."
        fi
        ;;
    "Partly cloudy")
        if [ "$period" = "day" ]; then
            icon="󰖍"
            message="A mix of sun and clouds today."
        else
            icon=""  # Icono alternativo para noche parcialmente nublada
            message="Partly cloudy night."
        fi
        ;;
    "Cloudy")
        if [ "$period" = "day" ]; then
            icon="󰖏"
            message="The sky is overcast with clouds."
        else
            icon="󰖏"
            message="Overcast night."
        fi
        ;;
    "Overcast")
        if [ "$period" = "day" ]; then
            icon="󰖏"
            message="A gray day with a thick cloud cover."
        else
            icon="󰖏"
            message="Overcast night."
        fi
        ;;
    "Mist")
        if [ "$period" = "day" ]; then
            icon="󰖑"
            message="A light mist hangs in the air."
        else
            icon="󰖑"
            message="Light mist at night."
        fi
        ;;
    "Patchy rain nearby")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Rain showers are possible nearby."
        else
            icon="󰖕"
            message="Rain showers are possible nearby (night)."
        fi
        ;;
    "Patchy snow nearby")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Snow flurries are expected in the area."
        else
            icon="󰖘"
            message="Snow flurries at night."
        fi
        ;;
    "Patchy sleet nearby")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Sleet may fall in some locations."
        else
            icon="󰖘"
            message="Sleet may fall at night."
        fi
        ;;
    "Patchy freezing drizzle nearby")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Freezing drizzle possible in some areas."
        else
            icon="󰖘"
            message="Freezing drizzle possible at night."
        fi
        ;;
    "Thundery outbreaks in nearby")
        if [ "$period" = "day" ]; then
            icon="󰖔"
            message="Thunderstorms may develop close by."
        else
            icon="󰖔"
            message="Thunderstorms possible at night."
        fi
        ;;
    "Blowing snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Snow is being blown around by strong winds."
        else
            icon="󰖘"
            message="Blowing snow with gusty winds at night."
        fi
        ;;
    "Blizzard")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="A blizzard with heavy snow and strong winds."
        else
            icon="󰖘"
            message="A blizzard at night with heavy snow."
        fi
        ;;
    "Fog")
        if [ "$period" = "day" ]; then
            icon="󰖑"
            message="Dense fog is reducing visibility."
        else
            icon="󰖑"
            message="Dense fog at night."
        fi
        ;;
    "Freezing fog")
        if [ "$period" = "day" ]; then
            icon="󰖑"
            message="Fog with potential for ice formation."
        else
            icon="󰖑"
            message="Freezing fog at night."
        fi
        ;;
    "Patchy light drizzle")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="A light drizzle is falling in some areas."
        else
            icon="󰖕"
            message="A light drizzle is falling at night."
        fi
        ;;
    "Light drizzle")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="A light drizzle is falling."
        else
            icon="󰖕"
            message="A light drizzle is falling at night."
        fi
        ;;
    "Freezing drizzle")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="A light freezing drizzle is falling."
        else
            icon="󰖕"
            message="A light freezing drizzle is falling at night."
        fi
        ;;
    "Heavy freezing drizzle")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="A heavy freezing drizzle is falling."
        else
            icon="󰖕"
            message="A heavy freezing drizzle is falling at night."
        fi
        ;;
    "Patchy light rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Light rain showers are expected."
        else
            icon="󰖕"
            message="Patchy light rain at night."
        fi
        ;;
    "Light rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Light rain is falling."
        else
            icon="󰖕"
            message="Light rain is falling at night."
        fi
        ;;
    "Moderate rain at times")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Rain is moderate at times."
        else
            icon="󰖕"
            message="Rain is moderate at night."
        fi
        ;;
    "Moderate rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Moderate rain is falling."
        else
            icon="󰖕"
            message="Moderate rain is falling at night."
        fi
        ;;
    "Heavy rain at times")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Heavy rain is expected at times."
        else
            icon="󰖕"
            message="Heavy rain expected at night."
        fi
        ;;
    "Heavy rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Heavy rain is falling."
        else
            icon="󰖕"
            message="Heavy rain is falling at night."
        fi
        ;;
    "Light freezing rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Light freezing rain is falling."
        else
            icon="󰖕"
            message="Light freezing rain falling at night."
        fi
        ;;
    "Moderate or heavy freezing rain")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Freezing rain is falling."
        else
            icon="󰖕"
            message="Freezing rain is falling at night."
        fi
        ;;
    "Light sleet")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light sleet is falling."
        else
            icon="󰖘"
            message="Light sleet falling at night."
        fi
        ;;
    "Moderate or heavy sleet")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Sleet is falling."
        else
            icon="󰖘"
            message="Sleet is falling at night."
        fi
        ;;
    "Patchy light snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light snow flurries are expected."
        else
            icon="󰖘"
            message="Light snow flurries at night."
        fi
        ;;
    "Light snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light snow is falling."
        else
            icon="󰖘"
            message="Light snow is falling at night."
        fi
        ;;
    "Patchy moderate snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Moderate snow flurries are expected."
        else
            icon="󰖘"
            message="Moderate snow flurries at night."
        fi
        ;;
    "Moderate snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Moderate snow is falling."
        else
            icon="󰖘"
            message="Moderate snow is falling at night."
        fi
        ;;
    "Patchy heavy snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Heavy snow flurries are expected."
        else
            icon="󰖘"
            message="Heavy snow flurries at night."
        fi
        ;;
    "Heavy snow")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Heavy snow is falling."
        else
            icon="󰖘"
            message="Heavy snow is falling at night."
        fi
        ;;
    "Ice pellets")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Ice pellets are falling."
        else
            icon="󰖘"
            message="Ice pellets are falling at night."
        fi
        ;;
    "Light rain shower")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Light rain showers are falling."
        else
            icon="󰖕"
            message="Light rain showers at night."
        fi
        ;;
    "Moderate or heavy rain shower")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Rain showers are falling."
        else
            icon="󰖕"
            message="Rain showers falling at night."
        fi
        ;;
    "Torrential rain shower")
        if [ "$period" = "day" ]; then
            icon="󰖕"
            message="Heavy rain showers are falling."
        else
            icon="󰖕"
            message="Heavy rain showers at night."
        fi
        ;;
    "Light sleet showers")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light sleet showers are falling."
        else
            icon="󰖘"
            message="Light sleet showers at night."
        fi
        ;;
    "Moderate or heavy sleet showers")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Sleet showers are falling."
        else
            icon="󰖘"
            message="Sleet showers falling at night."
        fi
        ;;
    "Light snow showers")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light snow showers are falling."
        else
            icon="󰖘"
            message="Light snow showers at night."
        fi
        ;;
    "Moderate or heavy snow showers")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Snow showers are falling."
        else
            icon="󰖘"
            message="Snow showers falling at night."
        fi
        ;;
    "Light showers of ice pellets")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Light ice pellet showers are falling."
        else
            icon="󰖘"
            message="Light ice pellet showers at night."
        fi
        ;;
    "Moderate or heavy showers of ice pellets")
        if [ "$period" = "day" ]; then
            icon="󰖘"
            message="Ice pellet showers are falling."
        else
            icon="󰖘"
            message="Ice pellet showers falling at night."
        fi
        ;;
    "Patchy light rain with thunder")
        if [ "$period" = "day" ]; then
            icon="󰖔"
            message="Light rain with thunder is possible."
        else
            icon="󰖔"
            message="Light rain with thunder at night."
        fi
        ;;
    "Moderate or heavy rain with thunder")
        if [ "$period" = "day" ]; then
            icon="󰖔"
            message="Thunderstorms with rain are possible."
        else
            icon="󰖔"
            message="Thunderstorms with rain at night."
        fi
        ;;
    "Patchy light snow with thunder")
        if [ "$period" = "day" ]; then
            icon="󰖔"
            message="Light snow with thunder is possible."
        else
            icon="󰖔"
            message="Light snow with thunder at night."
        fi
        ;;
    "Moderate or heavy snow with thunder")
        if [ "$period" = "day" ]; then
            icon="󰖔"
            message="Thunderstorms with snow are possible."
        else
            icon="󰖔"
            message="Thunderstorms with snow at night."
        fi
        ;;
    *)
        icon="󰖐"
        message="Weather conditions are unknown."
        ;;
esac

if [[ "$1" == --wind ]]; then
    echo "$wind_icon $windspeed km/h"
elif [[ "$1" == --detail ]]; then
    echo "$detail"
elif [[ "$1" == --C ]]; then
    echo "$C C°"
elif [[ "$1" == --location ]]; then
    echo "$location"
elif [[ "$1" == --icon ]]; then
    echo "$icon"
elif [[ "$1" == --message ]]; then
    echo "$message"
fi
