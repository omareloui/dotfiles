#!/usr/bin/env bash

version=1.1.0

. "$(dirname "$0")/utils.sh"

[[ -z $BOOTSTRAP_FILES ]] && BOOTSTRAP_FILES="$HOME/.dotfiles/bootstrap"

verbose=0
ignore_existing=0
should_confirm=0

LONGOPTS=ignore-existing,confirm,verbose,help
OPTIONS=icvh

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

while true; do
	case "$1" in
	-i | --ignore-existing)
		ignore_existing=1
		shift
		;;
	-v | --verbose)
		verbose=1
		shift
		;;
	-c | --confirm)
		should_confirm=1
		shift
		;;
	-h | --help)
		echo -e ""
		echo -e "  ${BOLD}Usage:${END_BOLD}    $(basename "$0") ${YELLOW}[${B_RED}options${DARK_GRAY}...${YELLOW}]${RESET}" # ${YELLOW}<${GREEN}action${YELLOW}>${RESET}"
		echo -e "  ${BOLD}Version:${RESET}  ${YELLOW}$version${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Description:${RESET}"
		echo -e ""
		echo -e "    ${B_GRAY}Copy required udev rules to their location.${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Options:${RESET}"
		echo -e ""
		echo -e "    ${BLUE}-h${RESET}, ${BLUE}--help${RESET}             ${B_RED}-${RESET} Show this help and exit."
		echo -e "    ${BLUE}-v${RESET}, ${BLUE}--verbose${RESET}          ${B_RED}-${RESET} Explain what is being done."
		echo -e "    ${BLUE}-c${RESET}, ${BLUE}--confirm${RESET}          ${B_RED}-${RESET} Ask before copying."
		echo -e "    ${BLUE}-i${RESET}, ${BLUE}--ignore-existing${RESET}  ${B_RED}-${RESET} Ignores already existing configs."
		echo -e ""
		echo -e "  ${BOLD}Examples:${RESET}"
		echo -e ""
		echo -e "    ${RED}\$${RESET} ${B_MAGENTA}$(basename "$0")${RESET}"
		echo -e "    ${RED}\$${RESET} ${B_MAGENTA}$(basename "$0")${RESET} -v"
		echo -e ""
		exit 0
		;;
	--)
		shift
		break
		;;
	*)
		echo -e "${RED}Error:${RESET} Programming error"
		exit 3
		;;
	esac
done

function p() {
	if ((verbose == 1)); then
		echo -e "$1"
	fi
}

udef_files="$(fd ".*\.rules" "$BOOTSTRAP_FILES/assets/udev")"

override="$( ((ignore_existing == 1)) && echo 0 || echo 1)"

for rule in $udef_files; do
	dest="/etc/udev/rules.d/$(basename "$rule")"

	prompt_confirmation "${BOLD}Copy ${UNDERLINE}$rule${END_UNDERLINE}${B_MAGENTA}?${END_BOLD}"
	confirmed="$(confirm)"

	if ((confirmed == 1)); then
		copy "$rule" "$dest" "$override" "$verbose"
	else
		p "${BLUE}Info${YELLOW}:${RESET} skipping ${UNDERLINE}$rule${END_UNDERLINE}"
	fi
done
