virtuoso-repository:
  pkgrepo.managed:
    - humanname: virtuoso-repository 
    - name: deb http://packages.comsode.eu/debian/ jessie main 
    - file: /etc/apt/sources.list.d/virtuoso.list
    - key_url: https://packages.comsode.eu/key/odn.gpg.key

virtuoso-server:
  pkg.installed:
    - refresh: True

virtuoso-default-file-installed:
  file.managed:
    - name: /etc/default/virtuoso-opensource-7
    - source: salt://virtuoso-opensource-7/default
    - require:
      - pkg: virtuoso-server


virtuoso-ini-installed:
  file.managed:
    - source: salt://virtuoso-opensource-7/virtuoso.ini
    - name: /etc/virtuoso-opensource-7/virtuoso.ini
    - require:
      - pkg: virtuoso-server



{% if grains['provider'] == 'docker' %}

/etc/supervisor/conf.d/virtuoso-opensource-7.conf:
    file.managed:
      - source: salt://virtuoso-opensource-7/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
      - require_in:
        - {{ grains['service_provider'] }}: virtuoso-server

{% endif %}

