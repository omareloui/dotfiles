#!/usr/bin/env bash

# to get this list run `$SCRIPTS/update_packageslist`

version=1.0.1

. "$(dirname "$0")/utils.sh"

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
		echo -e ""
		echo -e "  ${BOLD}Usage:${END_BOLD}    $(basename "$0") ${YELLOW}[${B_RED}options${DARK_GRAY}...${YELLOW}]${RESET}"
		echo -e "  ${BOLD}Version:${RESET}  ${YELLOW}$version${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Description:${RESET}"
		echo -e ""
		echo -e "    ${B_GRAY}Script to install packages from \"$BOOTSTRAP_FILES/assets/packages.lst\".${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Options:${RESET}"
		echo -e ""
		echo -e "    ${BLUE}-h${RESET}, ${BLUE}--help${RESET}       ${B_RED}-${RESET} Show this help and exit."
		echo -e "    ${BLUE}-v${RESET}, ${BLUE}--verbose${RESET}    ${B_RED}-${RESET} Explain what is being done."
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
		echo -e "${RED}Error:${RESET} programming error"
		exit 3
		;;
	esac
done

function p() {
	if ((verbose == 1)); then
		echo -e "$1"
	fi
}

function ensure_paru {
	p "${BLUE}Info${YELLOW}:${RESET} making sure paru is installed"
	if ! pacman -Qi paru &>/dev/null; then
		{
			p "${BLUE}Info${YELLOW}:${RESET} installing paru"
			sudo pacman -S --needed base-devel
			pushd /tmp || exit 1
			git clone https://aur.archlinux.org/paru.git
			cd paru || exit 1
			makepkg -si
			popd || exit 1
			rm -rf /tmp/paru
		} &&
			p "${GREEN}Success${YELLOW}:${RESET} installed paru" ||
			echo -e "${RED}Error${YELLOW}:${RESET} something went wrong while installing paru"
	else
		p "${BLUE}Info${YELLOW}:${RESET} paru already exist"
	fi
}

function install {
	p "${BLUE}Info${YELLOW}:${RESET} updating the system"
	paru -Syu --noconfirm &&
		p "${GREEN}Success${YELLOW}:${RESET} updated the system" ||
		echo -e "${RED}Error${YELLOW}:${RESET} something went wrong while updating the system"

	p "${BLUE}Info${YELLOW}:${RESET} installing the packages"
	xargs paru -S --needed --noconfirm <"$BOOTSTRAP_FILES/assets/packages.lst" &&
		p "${GREEN}Success${YELLOW}:${RESET} updated the system" ||
		echo -e "${RED}Error${YELLOW}:${RESET} something went wrong while installing the packages"
}

ensure_paru
install
