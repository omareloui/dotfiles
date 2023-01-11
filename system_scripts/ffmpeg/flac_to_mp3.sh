#!/usr/bin/bash

[[ ! -d "$PWD"/flac ]] && mkdir "$PWD/flac"
[[ ! -d "$PWD"/mp3 ]] && mkdir "$PWD/mp3"
[[ ! -d "$PWD"/backup ]] && mkdir "$PWD/backup"

cp "$PWD"/*.flac "$PWD/backup"
mv "$PWD"/*.flac "$PWD/flac"

for file in "$PWD"/flac/*; do
	filename=$(basename "$file" .flac)
	ffmpeg \
		-i "$file" \
		-ab 320k \
		-map_metadata 0 \
		-id3v2_version 3 \
		"$PWD"/mp3/"$filename".mp3
done

mv "$PWD"/mp3/* "$PWD"
rm -rf "$PWD"/mp3 "$PWD/flac"