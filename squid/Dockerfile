FROM alpine
MAINTAINER docker <docker@fserver.ru>

ENV LANG=ru

COPY start.sh /

RUN set -xe \
    && apk add --update --no-cache squid squid-lang-${LANG} \
    && rm -rf /var/cache/apk/* \
    && chmod +x /start.sh

VOLUME /etc/squid/squid.conf /var/cache/squid /var/log/squid

EXPOSE 3128 3129

ENTRYPOINT ["/start.sh"]
