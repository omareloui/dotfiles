#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

# Src: https://github.com/Raymo111/i3lock-color
tmp_dir=/tmp/i3lock-color
mkdir "$tmp_dir"

install_package autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

git_clone https://github.com/Raymo111/i3lock-color.git master "$tmp_dir"

cd $tmp_dir || exit 1

./install-i3lock-color.sh

cd - || exit 1
