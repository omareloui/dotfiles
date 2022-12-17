#!/bin/bash

DOTFILES=$HOME/dotfiles/config

apt list --installed \
  | awk "/\[installed\]/" \
  | sed "s/\/.*//" > $DOTFILES/packages.txt
