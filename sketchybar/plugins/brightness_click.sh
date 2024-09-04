#!/bin/sh

WIDTH=150

detail_on() {
	sketchybar --animate tanh 30 --set brightness slider.width=$WIDTH
}

detail_off() {
	sketchybar --animate tanh 30 --set brightness slider.width=0
}

INITIAL_WIDTH=$(sketchybar --query brightness | jq -r ".slider.width")
if [ "$INITIAL_WIDTH" -eq "0" ]; then
    detail_on
else
    detail_off
fi