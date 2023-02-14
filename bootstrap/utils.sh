#!/usr/bin/env bash

############################### Ansi ###############################
export BOLD="\e[1m"
export END_BOLD="\e[22m"
export UNDERLINE="\e[4m"
export END_UNDERLINE="\e[24m"
export REVERSE_TEXT="\e[7m"
export END_REVERSE="\e[27m"

export BLACK="\e[30m"
export BLACK_BG="\e[40m"
export WHITE="\e[97m"
export WHITE_BG="\e[107m"

export RED="\e[31m"
export RED_BG="\e[41m"
export GREEN="\e[32m"
export GREEN_BG="\e[42m"
export YELLOW="\e[33m"
export YELLOW_BG="\e[43m"
export BLUE="\e[34m"
export BLUE_BG="\e[44m"
export MAGENTA="\e[35m"
export MAGENTA_BG="\e[45m"
export CYAN="\e[36m"
export CYAN_BG="\e[46m"

export B_GRAY="\e[37m"
export B_GRAY_BG="\e[47m"
export DARK_GRAY="\e[90m"
export DARK_GRAY_BG="\e[100m"

export B_RED="\e[91m"
export B_RED_BG="\e[101m"
export B_GREEN="\e[92m"
export B_GREEN_BG="\e[102m"
export B_YELLOW="\e[93m"
export B_YELLOW_BG="\e[103m"
export B_BLUE="\e[94m"
export B_BLUE_BG="\e[104m"
export B_MAGENTA="\e[95m"
export B_MAGENTA_BG="\e[105m"
export B_CYAN="\e[96m"
export B_CYAN_BG="\e[106m"

export RESET="\e[0m"

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

	requires_sudo="$(echo "$dest" | grep -cP "^\/(usr|etc)")"

	function rm_w_sudo {
		_dest=$1
		if ((requires_sudo == 1)); then
			sudo rm -rf "$_dest"
		else
			rm -rf "$_dest"
		fi
	}

	function ln_w_sudo {
		_src=$1
		_dest=$2
		if ((requires_sudo == 1)); then
			sudo ln -s "$_src" "$_dest"
		else
			ln -s "$_src" "$_dest"
		fi
	}

	# remove already existing file/folder/symlink
	if [[ -e $dest || -L $dest ]]; then
		{
			rm_w_sudo "$dest" &&
				_p "$verbose" "${BLUE}Info${YELLOW}:${RESET} removed the old ${UNDERLINE}${dest}${END_UNDERLINE}."
		} || echo -e "${RED_BG}${BLACK}Error${RESET}${YELLOW}:${RESET} couldn't removed ${UNDERLINE}${dest}${END_UNDERLINE}."
	fi

	# create the symlink
	{

		ln_w_sudo "$src" "$dest" &&
			_p "$verbose" "${GREEN}Success${YELLOW}:${RESET} linked ${UNDERLINE}${dest}${END_UNDERLINE} to ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
	} || {
		echo -e "${RED_BG}${BLACK}Error${RESET}${YELLOW}:${RESET} couldn't create symlink for ${UNDERLINE}${src}${END_UNDERLINE}.${RESET}"
	}
}

function copy {
	src=$1
	dest=$2
	override=$3
	verbose=$4
	[[ -z $override ]] && override=0
	[[ -z $verbose ]] && verbose=0

	requires_sudo="$(echo "$dest" | grep -cP "^\/(usr|etc)")"

	if [[ $override -eq 0 && (-e $dest || -L $dest) ]]; then
		_p "$verbose" "${BLUE}Info${YELLOW}:${RESET} ${UNDERLINE}$dest${END_UNDERLINE} already exists, ignoring it.${RESET}"
		return
	fi

	function rm_w_sudo {
		_dest=$1
		if ((requires_sudo == 1)); then
			sudo rm -rf "$_dest"
		else
			rm -rf "$_dest"
		fi
	}

	function cp_w_sudo {
		_src=$1
		_dest=$2
		if ((requires_sudo == 1)); then
			sudo cp -r "$_src" "$_dest"
		else
			cp -r "$_src" "$_dest"
		fi
	}

	{
		rm_w_sudo "$dest" &&
			_p "$verbose" "${BLUE}Info${YELLOW}:${RESET} removed ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"
	} || echo -e "${RED_BG}${BLACK}Error${RESET}${YELLOW}:${RESET} something went wrong while deleting ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"

	{
		cp_w_sudo "$src" "$dest" &&
			_p "$verbose" "${GREEN}Success${YELLOW}:${RESET} copied ${UNDERLINE}$src${END_UNDERLINE} to ${UNDERLINE}$dest${END_UNDERLINE}.${RESET}"
	} || echo -e "${RED_BG}${BLACK}Error${RESET}${YELLOW}:${RESET} something went wrong while copying ${UNDERLINE}$src${END_UNDERLINE}.${RESET}"
}

function prompt_confirmation {
	prompt=$1
	if ((should_confirm == 1)); then
		echo -en "$prompt ${YELLOW}[${BLUE}yN${YELLOW}]${RESET} "
	fi
}

function confirm {
	if ((should_confirm == 1)); then
		read -r res
		if [[ -z $res || $res = "n" || $res = "N" || $res = "no" ]]; then
			echo 0
		elif [[ $res = "y" || $res = "Y" || $res = "yes" ]]; then
			echo 1
		else
			echo -e "${RED_BG}${BLACK}Error${RESET}${YELLOW}:${RESET} invalid input"
			exit 1
		fi
	else
		echo 1
	fi
}
