libapache2-mod-php5:
  pkg.installed

php5-joinup-stack:
  pkg.installed:
    - pkgs:
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


