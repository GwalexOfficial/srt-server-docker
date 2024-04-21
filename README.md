# SRT-Server for Docker

Build Image docker build --no-cache -t srt-server .

Run Container docker run -d --name srt-server --restart unless-stopped -p 8181:8181/tcp -p 8282:8282/udp srt-server
