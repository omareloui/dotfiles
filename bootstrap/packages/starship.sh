#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

has_curl="$(check_package_installed curl)"
((has_curl == 0)) && install_package curl

curl -sS https://starship.rs/install.sh | sh
