FROM debian:stable-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev wget git zlib1g-dev bash unattended-upgrades && \
    apt-get autoremove -y

RUN git clone https://github.com/Haivision/srt.git \
    && cd srt \
	&& ./configure \
	&& make \
	&& make install \
	&& cd

RUN git clone https://gitlab.com/mattwb65/srt-live-server.git \
	&& cd srt-live-server/ \
	&& make -j8 \
	&& rm sls.conf

RUN wget -O sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf \
	&& cd bin \
	&& ldconfig 

RUN echo 'APT::Periodic::Update-Package-Lists "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades && 
	
CMD unattended-upgrades & /srt-live-server/bin/sls -c /srt-live-server/bin/sls.conf -g "daemon off;"
