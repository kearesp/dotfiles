#!/bin/sh

WIDTH=150

brightness_change() {
    sketchybar --set $NAME slider.percentage=$INFO

    INITIAL_WIDTH="$(sketchybar --query $NAME | jq -r ".slider.width")"
	if [ "$INITIAL_WIDTH" -eq "0" ]; then
		sketchybar --animate tanh 30 --set $NAME slider.width=$WIDTH
	fi

    sleep 2

    # check if display brightness was changed while sleeping
	FINAL_PERCENTAGE="$(sketchybar --query $NAME | jq -r ".slider.percentage")"
	if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
		sketchybar --animate tanh 30 --set $NAME slider.width=0
	fi
}

mouse_clicked() {
    BRIGHTNESS_LEVEL=$(printf "%.2f" $(echo "$PERCENTAGE / 100" | bc -l))	
    /usr/local/bin/brightness $BRIGHTNESS_LEVEL
}

case "$SENDER" in
"brightness_change")
	brightness_change
	;;
"mouse.clicked")
	mouse_clicked
	;;
esac