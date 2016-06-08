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
      - php7.0-fpm 
      - php7.0-gd
      - php7.0-odbc
      - php7.0-mysqlnd
      - php7.0-apcu
      - php7.0-imap
      - php7.0-intl
      - php7.0-sqlite3
      - php7.0-ldap
      - php7.0-json
      - php7.0-mcrypt
      - php7.0-memcached
      - php7.0-cli
      - php7.0-curl
    - require:
      - pkg: apache2
      - pkgrepo: php7-repository

{% if grains['provider'] == 'docker' %}
/etc/supervisor/conf.d/php7-fpm.conf:
    file.managed:
      - source: salt://php7-fpm/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
        - pkg: php-stack
{% endif %}

/etc/apache2/conf-available/php7-fpm.conf:
  file.managed:
    - source: salt://php7-fpm/apache2.conf
    - template: jinja


enable-apache-proxy-fcgi:
  apache_module.enabled:
    - name: proxy_fcgi
    - require:
      - pkg: apache2

enable-apache-php7-fpm:
  apache_conf.enabled:
    - name: php7-fpm
    - require:
      - pkg: apache2
      - file: /etc/apache2/conf-available/php7-fpm.conf

php7.0-fpm:
  {{ grains['service_provider'] }}.running:
    - require:
      - pkg: php-stack
      - file: /etc/php/7.0/fpm/pool.d/www.conf
        
/etc/php/7.0/fpm/pool.d/www.conf:
  file.managed:
    - source: salt://php7-fpm/pool.conf
    - template: jinja
    - watch_in:
      - {{ grains['service_provider'] }}: php7.0-fpm
    
