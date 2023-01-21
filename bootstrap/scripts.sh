#!/usr/bin/env bash

# . utils.sh
. "$(dirname "$0")/utils.sh"

LONGOPTS=verbose,help
OPTIONS=vh

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

verbose=0

while true; do
	case "$1" in
	-v | --verbose)
		verbose=1
		shift
		;;
	-h | --help)
		echo "Usage: $(basename "$0") [OPTION]..."
		echo "Symlinks the scripts directory in the dotfiles to \$HOME/.local/bin."
		echo ""
		echo "WARNING: it remove the old folder make sure to back it up if needed."
		echo ""
		echo "-v, --verbose     prints out the process state"
		echo "-h, --help        show this help prompt"
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

function p() {
	if ((verbose == 1)); then
		echo -e "$1"
	fi
}

if [[ -z "$SCRIPTS" ]]; then
	SCRIPTS="$HOME/.dotfiles/scripts"
fi

create_sym "$SCRIPTS" "$HOME/.local/bin" $verbose
