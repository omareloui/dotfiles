#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

verbose=0
override=0

LONGOPTS=override,verbose,help
OPTIONS=ovh

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

while true; do
	case "$1" in
	-v | --verbose)
		verbose=1
		shift
		;;
	-o | --override)
		override=1
		shift
		;;
	-h | --help)
		echo "Usage: $(basename "$0") [OPTION]..."
		echo "Setup battery notification on plug/unplug and warnings on low level"
		echo ""
		echo "You can change the warning levels from $SCRIPTS/batwarning"
		echo ""
		echo "-v, --verbose     prints out the process state"
		echo "-h, --help        show this help prompt"
		echo "-o, --override    if the files exist in destination remove them and copy them again"
		echo ""
		exit 0
		;;
	--)
		shift
		break
		;;
	*)
		echo "Programming error"
		exit 3
		;;
	esac
done

function p {
	if ((verbose == 1)); then
		echo -e "$1"
	fi
}

plug_rule="$DOTFILES/assets/udev-rules/99-power.rules"
icons_dir=$HOME/.local/share/icons

[[ ! -d "$icons_dir" ]] && mkdir "$icons_dir"

for file in $(find "$DOTFILES/assets/icons/" -name "battery*.png" -type f); do
	copy "$file" "$icons_dir/$(basename "$file")" "$override" "$verbose"
done

copy "$plug_rule" "/etc/udev/rules.d/$(basename "$plug_rule")" "$override" "$verbose" 1 &&
	sudo udevadm control --reload
