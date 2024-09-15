#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
    exit 0
fi

case ${PERCENTAGE} in
[8-9][0-9] | 100)
    ICON="󱊣"
    ICON_COLOR=0xc4a6da95
    ;;
7[0-9])
    ICON="󱊣"
    ICON_COLOR=0xc4daa62e
    ;;
[4-6][0-9])
    ICON="󱊢"
    ICON_COLOR=0xc4f5a97f
    ;;
[1-3][0-9])
    ICON="󱊡"
    ICON_COLOR=0xc4ee99a0
    ;;
[0-9])
    ICON="󰂎"
    ICON_COLOR=0xc4ed8796
    ;;
esac

if [[ $CHARGING != "" ]]; then
    ICON="󱊦"
    ICON_COLOR=0xff01b500
fi

sketchybar --set $NAME \
    icon=$ICON \
    icon.font="Hack Nerd Font:Bold:20.0" \
    label="${PERCENTAGE}%" \
    icon.color=${ICON_COLOR}
