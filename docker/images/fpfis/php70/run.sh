#!/bin/bash
set -e
if [ ! -z "${DOCROOT}" ]; then
   rm /var/www/html -Rf
   # This allows for a future not-yet-created build folder to be created
   [ -d "${DOCROOT}" ] || mkdir "${DOCROOT}" 
   ln -s "$DOCROOT" /var/www/html
fi
source /etc/httpd/envvars
/usr/sbin/httpd -d /usr/lib64/httpd -f /etc/httpd/conf/httpd.conf -DFOREGROUND
