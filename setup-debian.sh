#!/bin/bash
cd $HOME;

# Download apps and libraries:
#
# From synaptic repo:
sudo apt-get update -y;
sudo apt-get upgrade -y;
sudo apt-get full-upgrade -y;
sudo apt-get install ncdu thunar javacc xwayland pipewire-audio flatpak build-essential curl fuzzel git lynx zsh nvim sway tree htop fonts-ibm-plex wayvnc wtype wl-clipboard grim slurp zip -y;
# Flatpak:
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# Install Cargo:
curl https://sh.rustup.rs -sSf>>cargo.sh;
chmod +x ./cargo.sh;
./cargo.sh -y;
rm ./cargo.sh;
source $HOME/.cargo/env;
# Install OhMyZSH:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "";

# Setup SSH:
ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519";

# Final config:
cd $HOME/personal-scripts
# ZSH:
cp zshrc $HOME/.zshrc
# NVIM:
mkdir -p $HOME/.config/nvim
cp init.vim $HOME/.config/nvim/init.vim
# Sway:
mkdir -p $HOME/.config/sway
cp swayconfig $HOME/.config/sway/config
# Foot:
mkdir -p $HOME/.config/foot
cp foot.ini $HOME/.config/foot/foot.ini
