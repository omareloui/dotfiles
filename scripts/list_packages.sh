#!/bin/bash

DOTFILES=$HOME/dotfiles

apt list --installed \
  | awk "/\[installed\]/" \
  | sed "s/\/.*//" > $DOTFILES/packages.txt
