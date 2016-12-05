#!/bin/bash

cd /srv/project/
sudo -u www-data vendor/bin/phing -propertyfile /usr/local/etc/subsite/subsite.ini execute-migration