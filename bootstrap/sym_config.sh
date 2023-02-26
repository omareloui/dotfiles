#!/usr/bin/env bash

version=2.0.2

. "$(dirname "$0")/utils.sh"

[[ -z $DOTFILES_CONFIG ]] && DOTFILES_CONFIG="$HOME/.dotfiles/config"
[[ -z $SCRIPTS ]] && SCRIPTS="$HOME/.dotfiles/scripts"

########## Define where the configs should be ##########
## From the root of $DOTFILES_CONFIG
# The key is the dest and the value is the config files/folders that will be
# symlinked from $DOTFILES_CONFIG
declare -A FROM_ROOT=(
	["$HOME"]=".zshenv .autostart"
	["$HOME/.config"]="nvim kitty fish eww lazygit starship.toml lf hypr neofetch mpd cava libinput-gestures.conf wlogout dunst rofi ncmpcpp zsh"
)

## Not in the root of $DOTFILES_CONFIG or to rename on dest
# Here it's the key is the src and the dest is the value
declare -A NOT_FROM_ROOT=(
	# Git
	["$DOTFILES_CONFIG/git/.gitconfig"]="$HOME/.gitconfig"
	# ["$DOTFILES_CONFIG/git/templates"]="$HOME/.config/git/templates"
	# ["$DOTFILES_CONFIG/git/.czrc"]="$HOME/.czrc" # Commitizen

	# ZK
	["$DOTFILES_CONFIG/zk"]="$ZK_NOTEBOOK_DIR/.zk"

	# ly
	["$DOTFILES_CONFIG/ly/config.ini"]="/etc/ly/config.ini"
)

##### Folders to make sure exist #####
[[ ! -d ~/.config/git ]] && mkdir ~/.config/git
[[ ! -d ~/.local/bin ]] && mkdir ~/.local/bin

############### Parse options ###############
verbose=0
ignore_existing=0

LONGOPTS=ignore-existing,verbose,help
OPTIONS=ivh

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
	-h | --help)
		echo -e ""
		echo -e "  ${BOLD}Usage:${END_BOLD}    $(basename "$0") ${YELLOW}[${B_RED}options${DARK_GRAY}...${YELLOW}]${RESET}"
		echo -e "  ${BOLD}Version:${RESET}  ${YELLOW}$version${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Description:${RESET}"
		echo -e ""
		echo -e "    ${B_GRAY}Create the required symlinks for system and applications configurations from ~/.dotfiles${RESET}"
		echo -e ""
		echo -e "  ${BOLD}Options:${RESET}"
		echo -e ""
		echo -e "    ${BLUE}-h${RESET}, ${BLUE}--help${RESET}             ${B_RED}-${RESET} Show this help and exist."
		echo -e "    ${BLUE}-v${RESET}, ${BLUE}--verbose${RESET}          ${B_RED}-${RESET} Explain what is being done."
		echo -e "    ${BLUE}-i${RESET}, ${BLUE}--ignore-existing${RESET}  ${B_RED}-${RESET} Ignores already existing configs."
		echo -e ""
		echo -e "  ${BOLD}Examples:${RESET}"
		echo -e ""
		echo -e "    ${RED}\$${RESET} ${B_MAGENTA}$(basename "$0")${RESET}"
		echo -e "    ${RED}\$${RESET} ${B_MAGENTA}$(basename "$0")${RESET} -vi"
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

########## Creating the symlinks ##########
for dir in "${!FROM_ROOT[@]}"; do
	configs=${FROM_ROOT[$dir]}
	for config in $configs; do
		dest="$dir/$config"
		[[ -e $dest && ignore_existing -eq 1 ]] && {
			p "${BLUE}Info${YELLOW}:${RESET} ${UNDERLINE}$dest${END_UNDERLINE} already exists, ignoring creating new symlink."
			continue
		}

		create_sym "$DOTFILES_CONFIG/$config" "$dest" "$verbose"
	done
done

p "${GREEN}Success${YELLOW}:${RESET} done symlinking from .dotfiles/config root files."

for src in "${!NOT_FROM_ROOT[@]}"; do
	dest=${NOT_FROM_ROOT[$src]}
	[[ -e $dest && ignore_existing -eq 1 ]] && {
		p "${BLUE}Info${YELLOW}:${RESET} ${UNDERLINE}$dest${END_UNDERLINE} already exists, ignoring creating new symlink."
		continue
	}
	create_sym "$src" "$dest" "$verbose"
done

p "${GREEN}Success${YELLOW}:${RESET} done symlinking not from .dotfiles/config root files."

# scripts
for src in $(fd -tx '^[^.]+$' "$SCRIPTS"); do
	dest="$HOME/.local/bin/$(basename "$src")"
	[[ -e $dest && ignore_existing -eq 1 ]] && {
		p "${BLUE}Info${YELLOW}:${RESET} ${UNDERLINE}$dest${END_UNDERLINE} already exists, ignoring creating new symlink."
		continue
	}
	create_sym "$src" "$dest" "$verbose"
done

p "${GREEN}Success${YELLOW}:${RESET} done symlinking scripts."
