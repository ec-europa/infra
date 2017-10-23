{% from "settings.map" import infra_settings with context %}

mailcatcher-stack:
  pkg.installed:
    - pkgs:
      - rubygems-integration
      - ruby2.0-dev
      - ruby2.0
      - build-essential
      - supervisor
      - libsqlite3-dev

mailcatcher:
  cmd.run:
    - name: gem2.0 install mailcatcher --no-ri --no-rdoc
    - creates: /usr/local/bin/catchmail
    - require:
      - pkg: mailcatcher-stack


## Usually, in master mode, you would ensure supervisor updates
## Here we don't care since its a packed VM that will update on boot time :

mailcatcher-daemon:
   file.managed:
     - name: /etc/supervisor/conf.d/mailcatcher.conf
     - source: salt://mailcatcher/supervisor.conf
     - require:
       - cmd: mailcatcher

{% if infra_settings.php == "7.0" %}
/etc/php/7.1/cli/conf.d/30-mailcatcher.ini:
  file.managed:
    - source: salt://mailcatcher/php.ini
    - require:
      - pkg: php-stack
      - pkg: apache2

/etc/php/7.1/apache2/conf.d/30-mailcatcher.ini:
  file.managed:
    - source: salt://mailcatcher/php.ini
    - require:
      - pkg: php-stack
      - pkg: apache2

{% else %}
/etc/php5/cli/conf.d/30-mailcatcher.ini:
  file.managed:
    - source: salt://mailcatcher/php.ini
    - require:
      - pkg: php-stack
      - pkg: apache2

/etc/php5/apache2/conf.d/30-mailcatcher.ini:
  file.managed:
    - source: salt://mailcatcher/php.ini
    - require:
      - pkg: php-stack
      - pkg: apache2

{% endif %}

