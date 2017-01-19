#!/bin/bash
source /etc/httpd/envvars
[ ! -z ${DOCROOT} ] && rm /var/www/html -Rf && ln -s "$DOCROOT" /var/www/html
/usr/sbin/httpd -d /usr/lib64/httpd -f /etc/httpd/conf/httpd.conf -DFOREGROUND

