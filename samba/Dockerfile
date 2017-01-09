FROM alpine
MAINTAINER docker <docker@fserver.ru>

RUN set -xe \
    && apk add -U samba-common-tools samba-server \
    && rm -rf /var/cache/apk/*

COPY smb.conf /etc/samba/

VOLUME /etc/samba \
       /var/lib/samba \
	   /share

EXPOSE 137/udp \
       138/udp \
       139/tcp \
       445/tcp

CMD nmbd -D && smbd -FS