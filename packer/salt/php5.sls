libapache2-mod-php5:
  pkg.installed

php5-joinup-stack:
  pkg.installed:
    - pkgs:
      - php5-gd
      - php5-odbc
      - php5-mysql

