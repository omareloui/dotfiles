#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

# Requirements
install_package "libsqlite3-dev libcurl3-dev cmake libglib2.0-dev"

pushd /tmp || exit 1

git_clone "https://github.com/sahib/glyr" "master"
cd glyr || exit

cmake -DCMAKE_INSTALL_PREFIX=/usr . &&
	make &&
	sudo make install

popd || exit 1
