# SRT-Server for Docker

For amd64 systems: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:latest

For arm64 systems: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:latest-arm64

#### Since v4.0 it use Alpine instead of Debian for better performance

## Usage:

Stream-URL: srt://ip:8282/publish/live/{stream}

Watch-URL: rtmp://ip:8282/publish/live/{stream}

Stats-URL: http://ip:8181/stats

{stream} is your streamkey, that can be anything

## Build Docker Image self:

wget https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/Dockerfile

Build Image: docker build --no-cache -t srt-server .

Run Container: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp srt-server

Docker Hub: [https://github.com/GwalexOfficial/srt-server-docker](https://hub.docker.com/r/gwalexofficial/srt-server)
