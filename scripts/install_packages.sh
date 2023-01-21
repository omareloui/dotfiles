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
	cmus \
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
	tree \
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

cd - || exit 1

############## Lock Screen (betterlockscreen) ##################
# Src: https://github.com/betterlockscreen/betterlockscreen

# Install i3lock-color
# Src: https://github.com/Raymo111/i3lock-color
sudo nala install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
mkdir /tmp/i3lock-color
git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color
cd /tmp/i3lock-color || exit 1
./install-i3lock-color.sh
cd - || exit 1

# Install image magic
# Src: https://ftp.imagemagick.org/script/install-source.php
# image_magick_download_dir="$HOME/.local/share/ImageMagick"
image_magick_download_dir="/tmp/imagemagic/"
mkdir "$image_magick_download_dir"
git clone https://github.com/ImageMagick/ImageMagick.git \
	--depth 1 \
	--branch main \
	--single-branch \
	"$image_magick_download_dir"
cd "$image_magick_download_dir" || exit 1
./configure
make
sudo make install
sudo ldconfig /usr/local/lib
cd - || exit 1

# betterlockscreen
cd /tmp || exit 1
wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip

cd - || exit 1
cd /tmp/betterlockscreen-main/ || exit 1
chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/

sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable --now "betterlockscreen@$USER"
cd - || exit 1
################################################################

exit 0
