#!/usr/bin/env bash

src=$1
ext=${src#*.}
output="$(basename "$src" ".$ext").webp"

ffmpeg -i "$src" -c:v libwebp "$output"
