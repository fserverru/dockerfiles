FROM alpine
MAINTAINER docker <docker@fserver.ru>

RUN apk add --no-cache minidlna

VOLUME /opt
WORKDIR /opt

EXPOSE 1900/udp
EXPOSE 8200/tcp

CMD ["minidlnad", "-d"]