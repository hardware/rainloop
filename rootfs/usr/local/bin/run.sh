#!/bin/sh

# Set attachment size and memory limit
sed -i -e "s/<UPLOAD_MAX_SIZE>/$UPLOAD_MAX_SIZE/g" /nginx/conf/nginx.conf /php/etc/php-fpm.conf \
       -e "s/<MEMORY_LIMIT>/$MEMORY_LIMIT/g" /php/etc/php-fpm.conf

# Fix permissions
chown -R $UID:$GID /rainloop/data /etc/s6.d /nginx /php /var/log

# RUN !
exec su-exec $UID:$GID /bin/s6-svscan /etc/s6.d
