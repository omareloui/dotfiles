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

# pnpm
sudo npm install -g pnpm

# Set the default shell to be fish
chsh -s /usr/bin/fish
sudo echo "/usr/local/bin/fish" | sudo tee -a /etc/shells

# Install commitizen to build a standered for git
# https://bitspeicher.blog/how-to-be-a-good-commitizen/
pnpm -g add commitizen cz-conventional-changelog devmoji

# Install tpm (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm \
	--depth 1 \
	--branch master \
	--single-branch \
	~/.tmux/plugins/tpm

# Install golang
cd /tmp || exit 1
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz

# Install zk (Zettelkasten) to maintain my notes
git clone https://github.com/mickael-menu/zk \
	--depth 1 \
	--branch main \
	--signle-branch \
	/tmp
cd /tmp/zk || exit 1
sudo make
sudo mv /tmp/zk/zk /usr/local/bin/

cd ~ || exit 1
exit 0
