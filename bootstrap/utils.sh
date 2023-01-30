#!/usr/bin/env bash

############################### Ansi ###############################
BOLD="\e[1m" END_BOLD="\e[22m"
UNDERLINE="\e[4m" END_UNDERLINE="\e[24m"
REVERSE_TEXT="\e[7m" END_REVERSE="\e[27m"

BLACK="\e[30m" BLACK_BG="\e[40m"
WHITE="\e[97m" WHITE_BG="\e[107m"

RED="\e[31m" RED_BG="\e[41m"
GREEN="\e[32m" GREEN_BG="\e[42m"
YELLOW="\e[33m" YELLOW_BG="\e[43m"
BLUE="\e[34m" BLUE_BG="\e[44m"
MAGENTA="\e[35m" MAGENTA_BG="\e[45m"
CYAN="\e[36m" CYAN_BG="\e[46m"

BRIGHT_GRAY="\e[37m" BRIGHT_GRAY_BG="\e[47m"
DARK_GRAY="\e[90m" DARK_GRAY_BG="\e[100m"

BRIGHT_RED="\e[91m" BRIGHT_RED_BG="\e[101m"
BRIGHT_GREEN="\e[92m" BRIGHT_GREEN_BG="\e[102m"
BRIGHT_YELLOW="\e[93m" BRIGHT_YELLOW_BG="\e[103m"
BRIGHT_BLUE="\e[94m" BRIGHT_BLUE_BG="\e[104m"
BRIGHT_MAGENTA="\e[95m" BRIGHT_MAGENTA_BG="\e[105m"
BRIGHT_CYAN="\e[96m" BRIGHT_CYAN_BG="\e[106m"

RESET="\e[0m"

############################### Functions ###############################
function _p {
	verbose=$1
	[[ -z $verbose ]] && verbose=0
	if ((verbose == 1)); then
		echo -e "$2"
	fi
}

function create_sym {
	src=$1
	dest=$2
	verbose=$3
	[[ -z $verbose ]] && verbose=0

	requires_sudo="$(echo "$dest" | grep -cP "^\/usr")"

	if [[ -e $dest || -L $dest ]]; then
		{
			{
				if ((requires_sudo > 0)); then
					sudo rm -rf "$dest"
				else
					rm -rf "$dest"
				fi
			}
			_p "$verbose" "${BLUE}Info:${RESET} removed ${UNDERLINE}${dest}${END_UNDERLINE}."
		} ||
			echo -e "${RED_BG}${BLACK}Error:${RESET} couldn't removed ${UNDERLINE}${dest}${END_UNDERLINE}."
	fi

	{
		{
			if ((requires_sudo > 0)); then
				sudo ln -s "$src" "$dest"
			else
				ln -s "$src" "$dest"
			fi
		} &&
			_p "$verbose" "${GREEN}Success:${RESET} linked ${UNDERLINE}${dest}${END_UNDERLINE} to ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
	} || {
		echo -e "${RED_BG}${BLACK}Error:${RESET} couldn't create symlink for ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
	}
}

function copy {
	src=$1
	dest=$2
	override=$3
	verbose=$4
	as_root=$5
	[[ -z $override ]] && override=0
	[[ -z $verbose ]] && verbose=0
	[[ -z $as_root ]] && as_root=0

	if [[ -e $dest || -L $dest ]]; then
		if ((override == 1)); then
			{
				{
					if ((as_root == 1)); then
						sudo rm -rf "$dest"
					else
						rm -rf "$dest"
					fi
				} && _p "$verbose" "Removed ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"
			} || _p "$verbose" "${RED}Something went wrong while deleting ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"
		else
			_p "$verbose" "${BLUE}${UNDERLINE}$dest${END_UNDERLINE} already exists${RESET}"
			return 0
		fi
	fi

	{
		{
			if ((as_root == 1)); then
				sudo cp -r "$src" "$dest"
			else
				cp -r "$src" "$dest"
			fi
		} &&
			_p "$verbose" "${GREEN}Copied ${UNDERLINE}$src${END_UNDERLINE} to ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"
	} || {
		_p "$verbose" "${RED}Something went wrong while copying $1.${RESET}"
	}
}

function is_root {
	if (("$(id -u)" != 0)); then
		echo -e "${RED}Please run as root.${RESET}"
		exit 1
	fi
}
