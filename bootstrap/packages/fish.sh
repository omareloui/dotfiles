#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

has_curl="$(check_package_installed curl)"
((has_curl == 0)) && install_package curl

install_package fish

# Fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install edc/bass

# Set the default shell to be fish
chsh -s /usr/bin/fish
sudo echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
