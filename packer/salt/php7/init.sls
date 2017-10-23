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
      - libapache2-mod-php7.1
      - php7.1-gd
      - php7.1-odbc
      - php7.1-imap
      - php7.1-intl
      - php7.1-sqlite3
      - php7.1-ldap
      - php7.1-json
      - php7.1-mcrypt
      - php7.1-cli
      - php7.1-curl
      - php7.1-xml
      - php7.1-mysql
      - php7.1-mbstring
      - php7.1-zip
    - require:
      - pkg: apache2
      - pkgrepo: php7-repository

