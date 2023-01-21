#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

# Src: https://ftp.imagemagick.org/script/install-source.php
image_magick_download_dir="/tmp/imagemagic/"

[[ ! -d $image_magick_download_dir ]] && mkdir "$image_magick_download_dir"

git_clone https://github.com/ImageMagick/ImageMagick.git main $image_magick_download_dir

cd "$image_magick_download_dir" || exit 1

./configure

make

sudo make install

sudo ldconfig /usr/local/lib

cd - || exit 1
