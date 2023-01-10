#!/bin/bash

apt list --installed |
	awk "/\[installed\]/" |
	sed "s/\/.*//" >"$DOTFILES/packages.txt"
