#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

install_package lf

# to preview images
# Check the requirements list here <https://github.com/thimc/lfimg>

install_package "ffmpegthumbnailer poppler-utils wkhtmltopdf catdoc docx2txt odt2txt gnumeric exiftool"

echo -e "${BLUE_BG}${BLACK}INFO:${RESET} ${BLUE}this script assums you have imagemagic installed if this isn't the case comment out the line in this script to install it or run $(dirname "$0")/imagemagick.sh manually.${RESET}"
# . "$(dirname "$0")/imagemagick.sh"

pushd /tmp || exit 1

git_clone https://github.com/thimc/lfimg.git "master"
cd lfimg || exit 1

if [[ ! -e "$HOME/.config/lf/lfrc" ]]; then
	touch "$HOME/.config/lf/lfrc"
	echo "set previewer ~/.config/lf/preview" >>"$HOME/.config/lf/lfrc"
	echo "set cleaner ~/.config/lf/cleaner" >>"$HOME/.config/lf/lfrc"
fi

make install

cd .. || exit

rm -rf lfimg

popd || exit 1
