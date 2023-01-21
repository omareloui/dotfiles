#!/usr/bin/bash

. "$(dirname "$0")/utils.sh"

add_ppa_and_install "ppa:agornostal/ulauncher" "ulauncher"

# Requirements for extensions
pip3 install pytz tornado thefuzz fuzzywuzzy --user
