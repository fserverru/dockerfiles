FROM alpine
MAINTAINER docker <docker@fserver.ru>

RUN set -xe \
    && apk add -U squid \
    && rm -rf /var/cache/apk/*

EXPOSE 3128 3130

ENTRYPOINT ["/usr/sbin/squid", "-NYCd1"]