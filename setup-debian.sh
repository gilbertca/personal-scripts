!/bin/bash
# when running this script, set the environment variable
# PASSWORD=[your password] to ensure you don't hang
# on any interactive prompts
if [[ -z $PASSWORD ]] ; then
        echo "You didn't set the PASSWORD environment variable. The script will hang.";
        return 1;
fi

# cd to home directory:
cd $HOME;

# Download apps and libraries:
#
# From synaptic repo:
sudo apt-get update -y;
sudo apt-get upgrade -y;
sudo apt-get full-upgrade -y;
sudo apt-get install ncdu thunar javacc xwayland pipewire-audio flatpak build-essential curl fuzzel git lynx zsh vim sway tree htop -y;
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
curl -fsSL https://ollama.com/install.sh | sh;
# Install zellij (compiled in background) (TODO:
#                               script reboots at the end, defeating the purpose)
#git clone https://github.com/zellij-org/zellij;
#cd ./zellij;
#nohup cargo build --release -j 1>/dev/null&
#cd $HOME;

# Setup SSH:
ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519";

# Add configurations to .zshrc:
#
# Editor = vim:
echo """
export EDITOR=vim
""">>$HOME/.zshrc;
# Start sway on tty1:
echo """
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec sway
fi
""">>$HOME/.zshrc;

# Add configuration to .config/sway/config
#
# Create config if it doesn't exist:
if [[ ! -e $HOME/.config/sway/config ]] ; then
        # mkdir ignores existing dirs, so we can safely 'create' them all
        mkdir $HOME/.config;
        mkdir $HOME/.config/sway;
        cp /etc/sway/config $HOME/.config/sway/;
fi
# Set magenta focus, remove titlebars:
echo """
default_border pixel 1
client.focused #FF00FF #FF00FF #000000
""">>$HOME/.config/sway/config;
# Set wallpaper and display settings:
# Update workspace keys:
# Set volume:
echo """
bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
""">>$HOME/.config/sway/config;
~                                    
