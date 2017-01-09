FROM alpine:latest
MAINTAINER docker <docker@fserver.ru>

RUN apk add --update --no-cache build-base gcc abuild binutils cmake git \
    && mkdir -p /usr/local/src \
    && cd /usr/local/src \
    && git clone https://github.com/Wind4/vlmcsd.git \
    && cd /usr/local/src/vlmcsd \
    && make \
    && mv /usr/local/src/vlmcsd/bin/vlmcsd / \
    && chmod +x /vlmcsd \
    && apk del build-base gcc abuild binutils cmake git \
    && rm -rf /usr/local/src/* \
    && rm -rf /var/cache/apk/*

EXPOSE 1688

CMD ["/vlmcsd", "-v", "-D", "-d", "-t", "3", "-e"]
