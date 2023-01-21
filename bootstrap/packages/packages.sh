#!/usr/bin/bash

. "$(dirname "$0")/utils.sh"

has_nala="$(check_package_installed nala)"

((has_nala == 0)) && sudo apt install nala

packages_utils=(
	build-essential
	libfuse2
)

terminal_utils=(
	bat
	bpytop
	cmus
	curl
	entr
	exa
	fd-find
	ffmpeg
	fzf
	ripgrep
	tree
	wmctrl
	xclip
	zoxide
)

applications=(
	keepassxc
	neovim
	telegram-desktop
	tmux
	vlc
)

package_managers=(
	python3-pip
)

install_package "${packages_utils[*]} ${terminal_utils[*]} ${applications[*]} ${package_managers[*]}"
