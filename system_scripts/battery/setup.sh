#!/usr/bin/env bash

files=("99-power.rules")
src_dir="/home/omareloui/dotfiles/system_scripts/battery/assets"
dest=/etc/udev/rules.d

for file in "${files[@]}"; do
	sudo rm -r "$dest/$file"
	sudo ln -s "$src_dir/$file" "$dest/$file"
done

sudo udevadm control --reload
