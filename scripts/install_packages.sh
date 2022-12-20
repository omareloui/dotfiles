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
  bat \
  bpytop \
  build-essential \
  entr \
  exa \
  fd-find \
  ffmpeg \
  fish \
  fzf \
  gnome-shell-extensions \
  gnome-tweaks \
  inkscape \
  keepassxc \
  libfuse2 \
  neovim \
  nodejs \
  python3-pip \
  ripgreb \
  telegram-desktop \
  tmux \
  ulauncher \
  vlc \
  wmctrl \
  xclip \
  zoxide

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


# Install tpm (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

