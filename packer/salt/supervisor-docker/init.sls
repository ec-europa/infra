supervisor-docker-service:
  service.running:
    - name: supervisor
    - require:
      - file: supervisor-docker-config

supervisor-docker-stack:
  pkg.installed:
    - pkgs:
      - supervisor
      - rsync

supervisor-docker-config:
  file.managed:
    - name: /etc/supervisor/conf.d/10-docker.conf
    - source: salt://supervisor-docker/supervisor.conf
    - require:
      - pkg: supervisor-docker-stack

/start.sh:
  file.managed:
    - source: salt://supervisor-docker/start.sh
    - mode: 755