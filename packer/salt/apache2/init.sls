apache2:
  pkg.installed

apache-default-site-config:
  file.managed:
    - name: /etc/apache2/sites-available/000-default.conf
    - source: salt://apache2/default-site.conf
    - template: jinja

apache2-service:
  {{ grains['service_provider'] }}.running:
    - update: true
    - name: apache2
    - require:
      - pkg: apache2

{% if grains['provider'] == 'docker' %}
/etc/supervisor/conf.d/apache2.conf:
    file.managed:
      - source: salt://apache2/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
      - require_in:
        - {{ grains['service_provider'] }}: apache2-service
{% endif %}
