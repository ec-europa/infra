php56-repository:
  pkgrepo.managed:
    - humanname: php56-repository
    - name: deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main
    - file: /etc/apt/sources.list.d/php56.list
    - keyid: E5267A6C
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true


php-stack:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php5
      - php5-gd
      - php5-odbc
      - php5-mysqlnd
      - php5-apcu
      - php5-imap
      - php5-intl
      - php5-sqlite
      - php5-ldap
      - php5-json
      - php5-mcrypt
      - php5-memcached
      - php5-cli
      - php5-curl
    - require:
      - pkg: apache2
      - pkgrepo: php56-repository

/etc/apache2/conf-enabled/php7-fpm.conf:
  file.absent
