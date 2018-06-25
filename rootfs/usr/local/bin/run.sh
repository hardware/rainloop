#!/bin/sh

# Set attachment size limit
sed -i "s/<UPLOAD_MAX_SIZE>/$UPLOAD_MAX_SIZE/g" /etc/php7/php-fpm.conf /etc/nginx/nginx.conf
sed -i "s/<MEMORY_LIMIT>/$MEMORY_LIMIT/g" /etc/php7/php-fpm.conf

# Remove postfixadmin-change-password plugin if exist
if [ -d "/rainloop/data/_data_/_default_/plugins/postfixadmin-change-password" ]; then
  rm -rf /rainloop/data/_data_/_default_/plugins/postfixadmin-change-password
fi

# Set log output to STDOUT if wanted (LOG_TO_STDOUT=true)
if [ "$LOG_TO_STDOUT" = true ]; then
  echo "[INFO] Logging to stdout activated"
  chmod o+w /dev/stdout
  sed -i "s/.*error_log.*$/error_log \/dev\/stdout warn;/" /etc/nginx/nginx.conf
  sed -i "s/.*error_log.*$/error_log = \/dev\/stdout/" /etc/php7/php-fpm.conf
fi

# Add postfixadmin-change-password plugin
mkdir -p /rainloop/data/_data_/_default_/plugins/
cp -r /usr/local/include/postfixadmin-change-password /rainloop/data/_data_/_default_/plugins/

# Fix permissions
chown -R $UID:$GID /rainloop/data /services /var/log /var/lib/nginx

# RUN !
exec su-exec $UID:$GID /bin/s6-svscan /services
