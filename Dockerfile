# Run linux spotify on macOS with an adblocker

# docker run -d \
# 	 -e DISPLAY=host.docker.internal:0 \
#	 -e PULSE_SERVER=docker.for.mac.localhost \
#	 -v $HOME/.spotify/config/home/spotify/.config/spotify \
#	 -v $HOME/.spotify/cache/home/spotify/spotify \
#	 -v ~/.config/pulse:/root/.config/pulse \
#	 --env ALSA_CARD=pulse \
#	 --group-add audio \
#	 --name spotify \
# 	 -d spotify:latest

FROM debian:sid-slim

RUN	apt-get update && apt-get install -y \
	dirmngr \
	gnupg \
        ca-certificates \
	--no-install-recommends \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4773BD5E130D1D45 \
	&& echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list \
	&& apt-get update && apt-get install -y \
	alsa-utils \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
        ffmpeg \
        xterm \
        nano \
        git \
        build-essential \
        libcurl4-openssl-dev \
        pulseaudio \
	spotify-client \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "load-module module-native-protocol-tcp" >> /etc/pulse/default.pa
RUN git clone https://github.com/AnanthVivekanand/spotify-adblock-macos.git && cd spotify-adblock-macos/adblocker && make

ENTRYPOINT	[ "xterm" ]
