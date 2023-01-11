#!/usr/bin/env bash

if [ -n "$SYSTEM_SCRIPTS" ]; then
	rm -r "$SYSTEM_SCRIPTS"
	ln -s "$DOTFILES/../system_scripts" "$SYSTEM_SCRIPTS"
fi
