#!/usr/bin/bash

. "$(dirname "$0")/../utils.sh"

# Font from Nerd Fonts
FONTS=(3270 FiraCode)

verbose=0

LONGOPTS=verbose,help
OPTIONS=vh

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

while true; do
	case "$1" in
	-v | --verbose)
		verbose=1
		shift
		;;
	-h | --help)
		echo "Usage: $(basename "$0") [OPTION]..."
		echo "Install basic fonts from Nerd Fonts"
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

dest="$HOME/.local/share/fonts"
tmp_folder=/tmp/install_fonts

[[ ! -d $tmp_folder ]] && mkdir $tmp_folder

for font in "${FONTS[@]}"; do
	p "${BLUE}Fetching ${UNDERLINE}$font${END_UNDERLINE}.${RESET}"
	wget -P $tmp_folder "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$font.zip"

	if [[ ! -e "$tmp_folder/$font.zip" ]]; then
		p "${RED}Something went wrong while downloading ${UNDERLINE}$font${END_UNDERLINE}.${RESET}"
		break
	fi

	p "${GREEN}Fetched ${UNDERLINE}$font${END_UNDERLINE}.${RESET}"

	{
		unzip -nqd "$tmp_folder" "$tmp_folder/$font.zip" &&
			p "${GREEN}Extracted ${UNDERLINE}$font${END_UNDERLINE}.${RESET}"
	} || {
		p "${RED}Couldn't extract ${UNDERLINE}$font${END_UNDERLINE}.${RESET}"
	}
done

{
	mkdir -p "$dest"
	find $tmp_folder \
		-type f \
		-name "*.otf" -or -name "*.ttf" \
		-exec mv {} "$dest" \;
} && p "${GREEN}Moved fonts to ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"

rm -rf $tmp_folder
