#!/usr/bin/bash

DOTFILES=$HOME/dotfiles

config_in_dot_config="nvim fish starship.toml"
config_in_home=".gitconfig"
vs_code_config="keybindings.json settings.json"

function create_sym {
  src=$1
  dest=$2
  rm $dest
  ln -s $src $dest
}

# Files and folders in ~/.config
for conf in $config_in_dot_config
do
  create_sym $DOTFILES/$conf $HOME/.config/$conf
done

# Files and folders in ~
for conf in $config_in_home
do
  create_sym $DOTFILES/$conf $HOME/$conf
done

for conf in $vs_code_config
do
  create_sym $DOTFILES/Code/$conf $HOME/.config/Code/User/$conf
done