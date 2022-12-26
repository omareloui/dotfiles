#!/usr/bin/bash

config_in_dot_config="nvim kitty awesome i3 polybar fish tmux lazygit starship.toml picom.conf"
# config_in_home=""
vs_code_config="keybindings.json settings.json"

function create_sym {
	src=$1
	dest=$2
	rm -r $dest
	ln -s $DOTFILES/$src $dest
}

# Files and folders in ~/.config
for conf in $config_in_dot_config; do
	create_sym $conf $HOME/.config/$conf
done

# Files and folders in ~
# for config in $config_in_home
# do
#   create_sym $DOTFILES/$conf $HOME/$conf
# done

for conf in $vs_code_config; do
	create_sym Code/$conf $HOME/.config/Code/User/$conf
done

# Git
create_sym git/.gitconfig ~/.gitconfig
[ ! -d ~/.config/git ] && mkdir ~/.config/git && create_sym git/templates ~/.config/git/templates
create_sym git/.czrc ~/.czrc
