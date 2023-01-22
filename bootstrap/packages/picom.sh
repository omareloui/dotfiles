#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

pushd /tmp || exit 1

git_clone "https://github.com/jonaburg/picom" "next"

cd picom || exit 1

meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

cd meson || exit 1

chmod +x install.sh
sudo ./install.sh

popd || exit 1
