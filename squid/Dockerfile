FROM alpine
MAINTAINER docker <docker@fserver.ru>

ENV LANG=ru

COPY start.sh /

RUN set -xe \
    && apk add --update --no-cache squid squid-lang-${LANG} \
    && rm -rf /var/cache/apk/* \
    && chmod +x /start.sh

EXPOSE 3128 3129

ENTRYPOINT ["/start.sh"]
