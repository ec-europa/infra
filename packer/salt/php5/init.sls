php56-repository:
  pkgrepo.managed:
    - humanname: php56-repository
    - name: deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main
    - file: /etc/apt/sources.list.d/php56.list
    - keyid: E5267A6C
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true


php-stack:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php56
      - php56-gd
      - php56-odbc
      - php56-mysqlnd
      - php56-apcu
      - php56-imap
      - php56-intl
      - php56-sqlite
      - php56-ldap
      - php56-json
      - php56-mcrypt
      - php56-memcached
      - php56-cli
      - php56-curl
    - require:
      - pkg: apache2
      - pkgrepo: php56-repository

/etc/apache2/conf-enabled/php7-fpm.conf:
  file.absent
