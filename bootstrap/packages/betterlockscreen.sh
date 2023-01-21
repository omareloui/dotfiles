#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

# Src: https://github.com/betterlockscreen/betterlockscreen
# Needs imagemagick and i3-color
has_imagemagick=$(check_package_installed "imagemagick")
has_i3lockcolor=$(which i3lock 2>/dev/null | grep -c "bin")

((has_imagemagick == 0)) && "$(dirname "$0")/imagemagick.sh"
((has_i3lockcolor == 0)) && "$(dirname "$0")/i3lock-color.sh"

# betterlockscreen
cd /tmp || exit 1

wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip

cd - || exit 1
cd /tmp/betterlockscreen-main/ || exit 1
chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/

sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable --now "betterlockscreen@$USER"
cd - || exit 1
