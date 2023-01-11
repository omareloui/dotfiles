#!/usr/bin/bash

if [ -n "$DOTFILES" ]; then
	"$DOTFILES/../scripts/install_config.sh"
	"$DOTFILES/../scripts/install_fonts.sh"
	"$DOTFILES/../scripts/install_packages.sh"
	"$DOTFILES/../scripts/install_system_scripts.sh"
fi
