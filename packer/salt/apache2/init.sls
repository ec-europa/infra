apache2:
  pkg.installed

apache-default-site-config:
  file.managed:
    - name: /etc/apache2/sites-available/000-default.conf
    - source: salt://apache2/default-site.conf