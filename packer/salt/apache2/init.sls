apache2:
  pkg.installed

apache-default-site-config:
  file.managed:
    - name: /etc/apache2/sites-available/000-default.conf
    - source: salt://apache2/default-site.conf
    - template: jinja

{% if grains['provider'] == 'docker' %}
/etc/supervisor/conf.d/apache2.conf:
    file.managed:
      - source: salt://apache2/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
{% endif %}
