#!/usr/bin/bash

FONTS="3270 FiraCode"
FONTS_DEST=/usr/local/share/fonts
tmp_folder=/tmp/install_fonts

mkdir $tmp_folder

for font in $FONTS
do
  wget -P $tmp_folder https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$font.zip
  unzip -nd $tmp_folder $tmp_folder/$font.zip
done

sudo mkdir -p $FONTS_DEST
sudo mv $tmp_folder/*.{o,t}tf $FONTS_DEST
rm -rf $tmp_folder
