#!/usr/bin/env bash

cd /tmp || exit 1

wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz

cd - || exit 1
