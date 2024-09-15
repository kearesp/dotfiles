#!/bin/sh

SSID=$(networksetup -getairportnetwork en0 | cut -d ':' -f 2 | xargs)
#ENABLED=$(networksetup -getnetworkserviceenabled Wi-Fi)
IP_ADDRESS=$(ipconfig getifaddr en0)

#sketchybar --set $NAME label="${SSID} (${IP_ADDRESS})"
sketchybar --set $NAME label="${SSID}"