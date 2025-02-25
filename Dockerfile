FROM alpine:3.21.3 AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache libinput-dev wget git make cmake tcl openssl-dev zlib-dev gcc perl tcl bash pkgconfig build-base linux-headers

RUN git clone --branch v1.5.4 --single-branch https://github.com/Haivision/srt.git && \
    cd srt && \
    cmake . && \
    make && \
    make install

RUN git clone https://gitlab.com/mattwb65/srt-live-server.git && \
    cd srt-live-server/ && \
    echo "#include <ctime>" | cat - slscore/common.cpp > /tmp/out && \
    mv /tmp/out slscore/common.cpp && \
    sed -i 's/conf_srt->http_port != NULL/conf_srt->http_port != 0/g' srt-live-server.cpp && \
    make -j8

FROM alpine:3.21.3

RUN apk update && apk upgrade && \
    apk add --no-cache libinput-dev tcl openssl-dev zlib-dev bash libstdc++ libc6-compat

COPY --from=builder /usr/local/lib/libsrt.* /usr/local/lib/
COPY --from=builder /srt-live-server /srt-live-server

RUN wget -O /srt-live-server/sls.conf https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/sls/conf/sls.conf

WORKDIR /srt-live-server/bin

CMD ["/bin/sh", "-c", "/srt-live-server/bin/sls -c /srt-live-server/sls.conf"]
