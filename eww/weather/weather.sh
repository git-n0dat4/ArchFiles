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
    "Sunny") icon="󰖙"; message="The sun is shining brightly.";;
    "Clear") icon="󰖐"; message="The sky is clear and peaceful.";;
    "Partly cloudy") icon="󰖍"; message="A mix of sun and clouds today.";;
    "Cloudy") icon="󰖏"; message="The sky is overcast with clouds.";;
    "Overcast") icon="󰖏"; message="A gray day with a thick cloud cover.";;
    "Mist") icon="󰖑"; message="A light mist hangs in the air.";;
    "Patchy rain nearby") icon="󰖕"; message="Rain showers are possible nearby.";;
    "Patchy snow nearby") icon="󰖘"; message="Snow flurries are expected in the area.";;
    "Patchy sleet nearby") icon="󰖘"; message="Sleet may fall in some locations.";;
    "Patchy freezing drizzle nearby") icon="󰖘"; message="Freezing drizzle possible in some areas.";;
    "Thundery outbreaks in nearby") icon="󰖔"; message="Thunderstorms may develop close by.";;
    "Blowing snow") icon="󰖘"; message="Snow is being blown around by strong winds.";;
    "Blizzard") icon="󰖘"; message="A blizzard with heavy snow and strong winds.";;
    "Fog") icon="󰖑"; message="Dense fog is reducing visibility.";;
    "Freezing fog") icon="󰖑"; message="Fog with potential for ice formation.";;
    "Patchy light drizzle") icon="󰖕"; message="A light drizzle is falling in some areas.";;
    "Light drizzle") icon="󰖕"; message="A light drizzle is falling.";;
    "Freezing drizzle") icon="󰖕"; message="A light freezing drizzle is falling.";;
    "Heavy freezing drizzle") icon="󰖕"; message="A heavy freezing drizzle is falling.";;
    "Patchy light rain") icon="󰖕"; message="Light rain showers are expected.";;
    "Light rain") icon="󰖕"; message="Light rain is falling.";;
    "Moderate rain at times") icon="󰖕"; message="Rain is moderate at times.";;
    "Moderate rain") icon="󰖕"; message="Moderate rain is falling.";;
    "Heavy rain at times") icon="󰖕"; message="Heavy rain is expected at times.";;
    "Heavy rain") icon="󰖕"; message="Heavy rain is falling.";;
    "Light freezing rain") icon="󰖕"; message="Light freezing rain is falling.";;
    "Moderate or heavy freezing rain") icon="󰖕"; message="Freezing rain is falling.";;
    "Light sleet") icon="󰖘"; message="Light sleet is falling.";;
    "Moderate or heavy sleet") icon="󰖘"; message="Sleet is falling.";;
    "Patchy light snow") icon="󰖘"; message="Light snow flurries are expected.";;
    "Light snow") icon="󰖘"; message="Light snow is falling.";;
    "Patchy moderate snow") icon="󰖘"; message="Moderate snow flurries are expected.";;
    "Moderate snow") icon="󰖘"; message="Moderate snow is falling.";;
    "Patchy heavy snow") icon="󰖘"; message="Heavy snow flurries are expected.";;
    "Heavy snow") icon="󰖘"; message="Heavy snow is falling.";;
    "Ice pellets") icon="󰖘"; message="Ice pellets are falling.";;
    "Light rain shower") icon="󰖕"; message="Light rain showers are falling.";;
    "Moderate or heavy rain shower") icon="󰖕"; message="Rain showers are falling.";;
    "Torrential rain shower") icon="󰖕"; message="Heavy rain showers are falling.";;
    "Light sleet showers") icon="󰖘"; message="Light sleet showers are falling.";;
    "Moderate or heavy sleet showers") icon="󰖘"; message="Sleet showers are falling.";;
    "Light snow showers") icon="󰖘"; message="Light snow showers are falling.";;
    "Moderate or heavy snow showers") icon="󰖘"; message="Snow showers are falling.";;
    "Light showers of ice pellets") icon="󰖘"; message="Light ice pellet showers are falling.";;
    "Moderate or heavy showers of ice pellets") icon="󰖘"; message="Ice pellet showers are falling.";;
    "Patchy light rain with thunder") icon="󰖔"; message="Light rain with thunder is possible.";;
    "Moderate or heavy rain with thunder") icon="󰖔"; message="Thunderstorms with rain are possible.";;
    "Patchy light snow with thunder") icon="󰖔"; message="Light snow with thunder is possible.";;
    "Moderate or heavy snow with thunder") icon="󰖔"; message="Thunderstorms with snow are possible.";;
    *) icon="󰖐"; message="Weather conditions are unknown.";; # Default icon and message if no match
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
