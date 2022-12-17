#!/usr/bin/bash

NODE_VERSION=19

sudo apt install nala curl

# For gnome-tweaks
sudo add-apt-repository -y universe

# Inkscap ppa
sudo add-apt-repository -y ppa:inkscape.dev/stable

# ULauncher ppa
sudo add-apt-repository -y ppa:agornostal/ulauncher

# Node ppa
curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | sudo -E bash -


sudo nala update



# Starship prompt
curl -sS https://starship.rs/install.sh | sh

sudo nala install -y \
  gnome-tweaks \
  gnome-shell-extensions \
  zoxide \
  exa \
  bat \
  xclip \
  bpytop \
  ffmpeg \
  python3-pip \
  nodejs \
  neovim \
  build-essential \
  fzf \
  fd-find \
  wmctrl \
  telegram-desktop \
  inkscape \
  ulauncher \
  fish \
  keepassxc \
  vlc

# Fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
fisher install edc/bass

# Deno
curl -fsSL https://deno.land/x/install/install.sh | sh

sudo nala update
sudo nala upgrade

sudo npm install -g pnpm

# Set the default shell to be fish
chsh -s /usr/bin/fish
sudo echo "/usr/local/bin/fish" >> /etc/shells


# Install commitizen to build a standered for git
# https://bitspeicher.blog/how-to-be-a-good-commitizen/
pnpm -g add commitizen cz-conventional-changelog devmoji
