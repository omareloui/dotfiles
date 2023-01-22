#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

pushd /tmp || exit 1

install_package "libxcb-cursor-dev libxcb-xtest0-dev libxcb-keysyms1-dev libxcb-icccm4-dev libstartup-notification0-dev libxdg-basedir-dev"

if [[ ! -d awesome ]]; then
	git_clone https://github.com/awesomewm/awesome master
fi

cd awesome || exit 1

make &&
	sudo make install

popd || exit 1
