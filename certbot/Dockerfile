FROM alpine:latest
MAINTAINER docker <docker@fserver.ru>

RUN apk add --no-cache --update certbot \
    && rm -rf /var/cache/apk/*

VOLUME /etc/letsencrypt /var/www

CMD ["certbot"]
