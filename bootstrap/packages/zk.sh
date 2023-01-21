#!/usr/bin/env bash

. "$(dirname "$0")/utils.sh"

git_clone https://github.com/mickael-menu/zk main /tmp

cd /tmp/zk || exit 1

sudo make
sudo mv /tmp/zk/zk /usr/local/bin/

cd - || exit 1
