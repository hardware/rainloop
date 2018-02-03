#!/bin/sh

# Set attachment size limit
sed -i "s/<UPLOAD_MAX_SIZE>/$UPLOAD_MAX_SIZE/g" /etc/php7/php-fpm.conf /etc/nginx/nginx.conf

# Remove postfixadmin-change-password plugin if exist
if [ -d "/rainloop/data/_data_/_default_/plugins/postfixadmin-change-password" ]; then
  rm -rf /rainloop/data/_data_/_default_/plugins/postfixadmin-change-password
fi

# Add postfixadmin-change-password plugin
cp -r /usr/local/include/postfixadmin-change-password /rainloop/data/_data_/_default_/plugins/

# Fix permissions
chown -R $UID:$GID /rainloop/data /services /var/log /var/lib/nginx

# RUN !
exec su-exec $UID:$GID /bin/s6-svscan /services
