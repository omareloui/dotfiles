#!/usr/bin/env bash

function opacify {
	color=$1
	opacity_percentage=$2

	opacity_in_rgb="$(echo "$opacity_percentage * 256 / 100" | bc)"
	opacity_hex="$(printf "%x" "$opacity_in_rgb")"

	echo "$color$opacity_hex"
}
