FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add --no-cache libinput-dev wget make cmake tcl openssl-dev zlib-dev gcc perl git unzip tcl bash pkgconfig libressl3 build-base

RUN git clone https://github.com/Haivision/srt.git \
    && cd srt \
    && cmake . \
    && make \
    && make install \
    && cd ..

RUN git clone https://gitlab.com/mattwb65/srt-live-server.git \
    && cd srt-live-server/ \
    && echo "#include <ctime>" | cat - slscore/common.cpp > /tmp/out && mv /tmp/out slscore/common.cpp \
    && make -j8 \
    && rm sls.conf

RUN wget -O /srt-live-server/sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf \
    && cd srt-live-server/bin \
    && ldconfig

WORKDIR /srt-live-server/bin/

CMD ["/bin/sh", "-c", "/srt-live-server/bin/sls -c /srt-live-server/sls.conf"]
