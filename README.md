# SRT-Server for Docker

For amd64 systems: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:latest

For arm64 systems: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:latest-arm64


## Build Docker Image self:

wget https://raw.githubusercontent.com/GwalexOfficial/srt-server-docker/main/Dockerfile

Build Image: docker build --no-cache -t srt-server .

Run Container: docker run -d --name srt-server --restart always -p 8181:8181/tcp -p 8282:8282/udp srt-server
