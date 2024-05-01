FROM debian:stable-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libinput-dev wget make cmake tcl openssl zlib1g-dev gcc perl git unzip tclsh pkg-config libssl-dev build-essential bash unattended-upgrades && \
    apt-get autoremove -y

RUN git clone https://github.com/Haivision/srt.git \
    && cd srt \
	&& ./configure \
	&& make \
	&& make install \
	&& cd

RUN git clone https://gitlab.com/mattwb65/srt-live-server.git \
	&& cd srt-live-server/ \
	&& echo "#include <ctime>"|cat - slscore/common.cpp > /tmp/out && mv /tmp/out slscore/common.cpp \
	&& make -j8 \
	&& rm sls.conf

RUN wget -O sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf \
	&& cd bin \
	&& ldconfig 

RUN echo 'APT::Periodic::Update-Package-Lists "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades

WORKDIR /srt-live-server/bin/
CMD ["./sls", "-c", "/../sls.conf"] & unattended-upgrades
