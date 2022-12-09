#!/bin/bash

apt list --installed \
  | awk "/\[installed\]/" \
  | sed "s/\/.*//" > packages.txt
