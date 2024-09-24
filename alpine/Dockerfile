FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add --no-cache libinput-dev wget make cmake tcl openssl-dev zlib-dev gcc perl git unzip tcl bash pkgconfig build-base linux-headers && \
    git clone https://github.com/Haivision/srt.git && \
    cd srt && \
    cmake . && \
    make && \
    make install && \
    cd .. && \
    git clone https://gitlab.com/mattwb65/srt-live-server.git && \
    cd srt-live-server/ && \
    echo "#include <ctime>" | cat - slscore/common.cpp > /tmp/out && \
    mv /tmp/out slscore/common.cpp && \
    sed -i 's/conf_srt->http_port != NULL/conf_srt->http_port != 0/g' srt-live-server.cpp && \
    make -j8 && \
    cd .. && \
    rm -rf srt srt-live-server /var/cache/apk/*

RUN wget -O /srt-live-server/sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf

WORKDIR /srt-live-server/bin

CMD ["/bin/sh", "-c", "/srt-live-server/bin/sls -c /srt-live-server/sls.conf"]
