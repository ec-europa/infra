get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/
    - require:
      - pkg: php-stack

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/local/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer


properties-composer-tmp-config:
  file.append:
    - name: /usr/local/etc/subsite/subsite.tmp.ini
    - makedirs: True
    - text:
      - "composer.bin=/usr/local/bin/composer"

