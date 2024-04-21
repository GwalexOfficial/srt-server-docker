FROM debian:stable-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libssl-dev wget git bash unattended-upgrades && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean

RUN cd /usr/local/bin \
    && git clone https://github.com/Haivision/srt.git \
    && cd srt \
    && ./configure \
    && make \
    && make install

RUN cd /usr/local/bin \
    && git clone https://gitlab.com/mattwb65/srt-live-server.git \
    && cd srt-live-server \
    && make -j8 \
    && mv sls.conf sls.bak \
    && wget -O /srt-live-server/sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf \
    && cd bin \
    && ldconfig

EXPOSE 8181
EXPOSE 8282

RUN echo 'APT::Periodic::Update-Package-Lists "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
	echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/20auto-upgrades && \
    echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades && \
    echo 'Unattended-Upgrade::Automatic-Reboot "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades && \
    echo 'Unattended-Upgrade::Automatic-Reboot-Time "02:00";' >> /etc/apt/apt.conf.d/50unattended-upgrades

CMD unattended-upgrades & /usr/local/bin/srt-live-server/bin ./sls -c ../sls.conf
