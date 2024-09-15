#!/bin/sh

WIDTH=150

detail_on() {
	sketchybar --animate tanh 30 --set volume slider.width=$WIDTH
}

detail_off() {
	sketchybar --animate tanh 30 --set volume slider.width=0
}

toggle_detail() {
	INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")
	if [ "$INITIAL_WIDTH" -eq "0" ]; then
		detail_on
	else
		detail_off
	fi
}

toggle_devices() {
	which SwitchAudioSource >/dev/null || exit 0
	args=(--remove '/volume.device\.*/' --set "$NAME" popup.drawing=toggle)
	COUNTER=0
	CURRENT="$(SwitchAudioSource -t output -c)"
	while IFS= read -r device; do
		COLOR=0xff827668
		if [ "${device}" = "$CURRENT" ]; then
			COLOR=0xffcdc09e
		fi
		args+=(--add item volume.device.$COUNTER popup."$NAME"
			--set volume.device.$COUNTER label="${device}"
				label.color="$COLOR"
				label.padding_left=7
				label.padding_right=7
				click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\.*/ label.color=0xffcdc09e --set \$NAME label.color=0xffcdc09e --set $NAME popup.drawing=off")
		COUNTER=$((COUNTER + 1))
	done <<<"$(SwitchAudioSource -a -t output)"

	sketchybar -m "${args[@]}" >/dev/null
}

if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
	toggle_devices
else
	toggle_detail
fi