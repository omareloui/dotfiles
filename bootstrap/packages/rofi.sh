#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

function install_rofi {
	pushd /tmp || exit 1

	git_clone "https://github.com/davatorium/rofi" "next"

	cd rofi || exit 1

	mkdir build
	cd build || exit 1

	../conigure
	make
	make install

	popd || exit 1
}

function install_fonts {
	FONT_DIR="$HOME/.local/share/fonts"

	cp "$DOTFILES/assets/fonts/Icomoon-Feather.ttf" "$FONT_DIR"
	cp "$DOTFILES/assets/fonts/GrapeNuts-Regular.ttf" "$FONT_DIR"
	cp "$DOTFILES/assets/fonts/Iosevka-Nerd-Font-Complete.ttf" "$FONT_DIR"
	cp "$DOTFILES/assets/fonts/JetBrains-Mono-Nerd-Font-Complete.ttf" "$FONT_DIR"
}

install_rofi
install_fonts
