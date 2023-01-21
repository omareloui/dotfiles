#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

add_ppa "universe"

install_package "gnome-shell-extensions gnome-tweaks" 1
