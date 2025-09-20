!/bin/bash
# when running this script, set the environment variable
# PASSWORD=[your password] to ensure you don't hang
# on any interactive prompts
if [[ -z $PASSWORD ]] ; then
        echo "You didn't set the PASSWORD environment variable. The script will hang.";
        return 1;
fi

cd $HOME;

# Download apps and libraries:
#
# From synaptic repo:
sudo apt-get update -y;
sudo apt-get upgrade -y;
sudo apt-get full-upgrade -y;
sudo apt-get install ncdu thunar javacc xwayland pipewire-audio flatpak build-essential curl fuzzel git lynx zsh vim sway tree htop fonts-ibm-plex wayvnc wtype wl-clipboard grim slurp zip -y;
# Flatpak:
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# Brave Browser:
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg;
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list;
sudo apt update -y;
sudo apt install brave-browser -y;
# Install Cargo:
curl https://sh.rustup.rs -sSf>>cargo.sh;
chmod +x ./cargo.sh;
./cargo.sh -y;
rm ./cargo.sh;
source $HOME/.cargo/env;
# Install OhMyZSH:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
echo $PASSWORD|chsh -s /bin/zsh; # --unattended flag disables chsh, so it must be done manually
# Install ollama: (TODO: set /etc/systemd/system/ollama.service
#                       to automatically include `Environment=OLLAMA_MODELS=/home/ollama`)
#curl -fsSL https://ollama.com/install.sh | sh;
# Install zellij (compiled in background) (TODO:
#                               script reboots at the end, defeating the purpose)
#git clone https://github.com/zellij-org/zellij;
#cd ./zellij;
#nohup cargo build --release -j 1>/dev/null&
#cd $HOME;

# Setup SSH:
ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519";

# Copy and setup config
#
# Download Git repo:
cd $HOME
mkdir $HOME/.config
git clone https://github.com/gilbertca/personal-scripts
cd personal-scripts
# ZSH and VIMRC:
cp vimrc $HOME/.vimrc
cp zshrc $HOME/.zshrc
# Sway:
mkdir $HOME/.config/sway
cp swayconfig $HOME/.config/sway/config
# Foot:
mkdir $HOME/.config/foot
cp foot.ini $HOME/.config/foot/foot.ini
