FROM debian:bookworm AS base

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
	apt-get install ncdu tmux wget javacc build-essential curl git lynx zsh neovim tree htop zip -y;\
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

# ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# sourcing
RUN echo "source /root/miniconda3/bin/activate">>~/.zshrc
RUN echo "source /root/.cargo/env">>~/.zshrc
WORKDIR "/root"

# include vnc server and xfce4 desktop
FROM base AS x-include
RUN apt-get install xfce4 xorg thunar brightnessctl tigervnc-standalone-server dbus-x11 fonts-ibm-plex -y
# config vnc
RUN mkdir -p /root/.config/tigervnc
RUN echo "#!/bin/bash\nstartxfce4">/root/.config/tigervnc/xstartup
RUN chmod +x /root/.config/tigervnc/xstartup
# install brave
RUN curl -fsS https://dl.brave.com/install.sh | sh

# without x
FROM base AS final
CMD ["/bin/zsh"]

# with x
FROM x-include AS final-x
CMD ["/bin/zsh"]
