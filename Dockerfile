FROM alpine:3.3
MAINTAINER Wonderfall <wonderfall@mondedie.fr>
MAINTAINER Hardware <contact@meshup.net>

ENV GID=991 UID=991

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk -U add \
    nginx \
    php-fpm \
    php-curl \
    php-iconv \
    php-xml \
    php-dom \
    php-openssl \
    php-json \
    php-zlib \
    php-pdo_mysql \
    php-pdo_sqlite \
    php-sqlite3 \
    supervisor \
    gnupg \
    tini@commuedge \
 && wget -q http://repository.rainloop.net/v2/webmail/rainloop-community-latest.zip -P /tmp \
 && wget -q http://repository.rainloop.net/v2/webmail/rainloop-community-latest.zip.asc -P /tmp \
 && wget -q http://repository.rainloop.net/RainLoop.asc -P /tmp \
 && gpg --import /tmp/RainLoop.asc \
 && gpg --verify /tmp/rainloop-community-latest.zip.asc \
 && mkdir /rainloop && unzip -q /tmp/rainloop-community-latest.zip -d /rainloop \
 && apk del gnupg \
 && rm -rf /tmp/* /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/php-fpm.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY startup /usr/local/bin/startup

RUN chmod +x /usr/local/bin/startup

VOLUME /rainloop/data
EXPOSE 80
LABEL description "Fast, simple and modern webmail client"
CMD ["tini","--","startup"]
