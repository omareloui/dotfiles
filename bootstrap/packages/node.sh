#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

NODE_VERSION=19

has_curl="$(check_package_installed curl)"
((has_curl == 0)) && install_package curl

curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | sudo -E bash -

install_package nodejs

# NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# pnpm
install_with_pnpm pnpm
