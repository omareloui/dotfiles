#!/usr/bin/env bash

############################### Ansi ###############################
# Lookup: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
BOLD="\e[1m"
END_BOLD="\e[22m"
UNDERLINE="\e[4m"
END_UNDERLINE="\e[24m"

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
BLACK="\e[30m"

BLUE_BG="\e[44m"

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

	if [[ -e $dest || -L $dest ]]; then
		rm -rf "$dest"
		_p "$verbose" "Removed ${UNDERLINE}${dest}${END_UNDERLINE}."
	fi

	{
		ln -s "$src" "$dest" &&
			_p "$verbose" "${GREEN}Linked  ${UNDERLINE}${dest}${END_UNDERLINE} to ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
	} || {
		_p "$verbose" "${RED}Couldn't create symlink for ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
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
