php7-repository:
  pkgrepo.managed:
    - humanname: php7-repository
    - name: deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main  
    - file: /etc/apt/sources.list.d/php7.list
    - keyid: E5267A6C
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true

php-stack:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php7.0
      - php7.0-gd
      - php7.0-odbc
      - php7.0-imap
      - php7.0-intl
      - php7.0-sqlite3
      - php7.0-ldap
      - php7.0-json
      - php7.0-mcrypt
      - php7.0-cli
      - php7.0-curl
      - php7.0-xml
      - php7.0-mysql
    - require:
      - pkg: apache2
      - pkgrepo: php7-repository

