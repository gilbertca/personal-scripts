#!/bin/bash
cd $HOME;
# By this point, you have already installed 'git' to download the personal-scripts repo
# Begin by updating apt sources:
sudo cp $HOME/personal-scripts/sources.list /etc/apt/sources.list
sudo chown root /etc/apt/sources.list

# Download apps and libraries:
sudo apt-get update -y;
sudo apt-get upgrade -y;
sudo apt-get full-upgrade -y;
sudo apt-get install brightnessctl ncdu thunar javacc xwayland pipewire-audio flatpak build-essential curl fuzzel lynx zsh neovim sway swaylock tree htop fonts-ibm-plex wayvnc wtype wl-clipboard grimshot zip -y;

# Install brave-browser
curl -fsS https://dl.brave.com/install.sh | sh

# Flatpak:
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Cargo:
curl https://sh.rustup.rs -sSf>>cargo.sh;
chmod +x ./cargo.sh;
./cargo.sh -y;
rm ./cargo.sh;
source $HOME/.cargo/env;

# Setup SSH:
ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519";

# Final config:
cd $HOME/personal-scripts

# ZSH:
cp zshrc $HOME/.zshrc

# NVIM:
mkdir -p $HOME/.config/nvim
cp init.vim $HOME/.config/nvim/init.vim &&echo "nvim.init moved"

# Sway:
mkdir -p $HOME/.config/sway
cp swayconfig $HOME/.config/sway/config &&echo "sway config moved"

# Foot:
mkdir -p $HOME/.config/foot
cp foot.ini $HOME/.config/foot/foot.ini &&echo "foot.ini moved"
# Script folder:

SCDIR=$HOME/scripts
mkdir -p $SCDIR
# Screenshots:

SSDIR=$HOME/screenshots
mkdir -p $SSDIR

# Install OhMyZSH last, since it will start Sway:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "";

