#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

# Install commitizen to build a standered for git
# https://bitspeicher.blog/how-to-be-a-good-commitizen/
install_with_pnpm "commitizen cz-conventional-changelog devmoji"
