#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

########## Define where the configs should be ##########
## From the root of $DOTFILES_CONFIG
# The key is the dest and the value is the config files/folders that will be
# symlinked from $DOTFILES_CONFIG
declare -A FROM_ROOT=(
	["$HOME"]=".fehbg"
	["$HOME/.config"]="nvim kitty betterlockscreenrc awesome rofi i3 polybar fish tmux lazygit starship.toml picom.conf lf"
)

## Not in the root of $DOTFILES_CONFIG or to rename on dest
# Here it's the key is the src and the dest is the value
declare -A NOT_FROM_ROOT=(
	# Git
	["$DOTFILES_CONFIG/git/.gitconfig"]="$HOME/.gitconfig"
	["$DOTFILES_CONFIG/git/templates"]="$HOME/.config/git/templates"
	["$DOTFILES_CONFIG/git/.czrc"]="$HOME/.czrc" # Commitizen

	# ZK
	["$DOTFILES_CONFIG/zk"]="$ZK_NOTEBOOK_DIR/.zk"

	# VS Code
	["$DOTFILES_CONFIG/VSCode/settings.json"]="$HOME/.config/Code/User/settings.json"
	["$DOTFILES_CONFIG/VSCode/keybindings.json"]="$HOME/.config/Code/User/keybindings.json"
)

##### Folders to make sure exist #####
[ ! -d ~/.config/git ] && mkdir ~/.config/git

############### Parse options ###############
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
		echo "Symlink the config to their location"
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

########## Creating the symlinks ##########
for dir in "${!FROM_ROOT[@]}"; do
	configs=${FROM_ROOT[$dir]}
	for config in $configs; do
		create_sym "$DOTFILES_CONFIG/$config" "$dir/$config" "$verbose"
	done
done

for src in "${!NOT_FROM_ROOT[@]}"; do
	dest=${NOT_FROM_ROOT[$src]}
	create_sym "$src" "$dest" "$verbose"
done
