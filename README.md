# SRT-Server for Docker

For amd64 systems: docker run -d --name srt-server --restart unless-stopped -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:v1-amd64
For arm64 systems: docker run -d --name srt-server --restart unless-stopped -p 8181:8181/tcp -p 8282:8282/udp gwalexofficial/srt-server:v1-arm64

Build Docker Image self:
Build Image docker build --no-cache -t srt-server .

Run Container docker run -d --name srt-server --restart unless-stopped -p 8181:8181/tcp -p 8282:8282/udp srt-server
