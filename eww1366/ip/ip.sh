#!/bin/bash
ipv4=$(ip -4 addr show ens33 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [[ "$1" == --ip ]]; then
    echo "$ipv4"
fi
