FROM debian:bookworm

# replace existing sources.list; include contrib and non-free
RUN cat <<'EOF' > /etc/apt/sources.list
deb http://deb.debian.org/debian/ trixie main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ trixie main non-free-firmware contrib non-free

deb http://security.debian.org/debian-security trixie-security main non-free-firmware contrib non-free
deb-src http://security.debian.org/debian-security trixie-security main non-free-firmware contrib non-free

deb http://deb.debian.org/debian/ trixie-updates main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ trixie-updates main non-free-firmware contrib non-free
EOF

# synaptic depends
RUN apt-get update -y;\
	apt-get install wget brightnessctl ncdu thunar javacc xwayland pipewire-audio flatpak build-essential curl fuzzel git lynx zsh neovim sway tree htop fonts-ibm-plex wayvnc wtype wl-clipboard grimshot zip xfce4 xorg tigervnc-standalone-server -y;\
	apt-get upgrade -y;

# ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# conda
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm ~/miniconda3/miniconda.sh

# cargo
RUN curl https://sh.rustup.rs -sSf>>cargo.sh;
RUN chmod +x ./cargo.sh;
RUN ./cargo.sh -y;
RUN rm ./cargo.sh;

RUN echo "source /root/miniconda3/bin/activate">>~/.zshrc
RUN echo "source /root/.cargo/env">>~/.zshrc

WORKDIR "/root"

CMD ["/bin/zsh"]
