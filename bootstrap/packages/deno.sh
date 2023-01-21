#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

has_curl="$(check_package_installed curl)"
((has_curl == 0)) && install_package curl

curl -fsSL https://deno.land/x/install/install.sh | sh

update_packages
