# Asterisk PBX
Alpine Linux based Docker image with Asterisk PBX

## Usage

1. Passthrough all port to container
```
docker run -d -t --privileged=true --net="host" --name asterisk fserver/alpine-asterisk
```

2. Passthrough only ones you need
```
docker run -d -p 5060:5060 -p XXXX:XXXX <add RTP ports> -v <configs-dir>:/etc/asterisk -v <call-recordings-dir>:/var/spool/asterisk/monitor -v <voicemail-dir>:/var/spool/asterisk/voicemail --name asterisk fserver/alpine-asterisk
```
dont forget to edit rtp.conf

3. Asterisk CLI:
```
docker exec -it asterisk asterisk -rvvvv
```

Example usage:
```
docker run -d -t --privileged=true --net="host" --restart=always -v /data/asterisk/etc:/etc/asterisk -v /data/asterisk/monitor:/var/spool/asterisk/monitor -v /data/asterisk/voicemail:/var/spool/asterisk/voicemail --name asterisk fserver/alpine-asterisk
```

Docker: [fserver/alpine-asterisk](https://hub.docker.com/r/fserver/alpine-asterisk/ "")
Github: [fserverru/docker-asterisk](https://github.com/fserverru/docker-asterisk "")