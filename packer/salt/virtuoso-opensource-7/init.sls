virtuoso-repository:
  pkgrepo.managed:
    - humanname: virtuoso-repository 
    - name: deb http://packages.comsode.eu/debian/ jessie main 
    - file: /etc/apt/sources.list.d/virtuoso.list
    - key_url: https://packages.comsode.eu/key/odn.gpg.key

virtuoso-server:
  pkg.installed:
    - refresh: True
  {{ grains['service_provider'] }}.running:
    - name: virtuoso-opensource-7
    - update: true
    - require:
      - file: virtuoso-default-file-installed

virtuoso-default-file-installed:
  file.managed:
    - name: /etc/default/virtuoso-opensource-7
    - source: salt://virtuoso-opensource-7/default
    - require:
      - pkg: virtuoso-server

unixodbc:
  pkg.installed

virtuoso-odbc-ini-installed:
  file.managed:
    - source: salt://virtuoso-opensource-7/odbc.ini
    - name: /etc/odbc.ini
    - require:
      - pkg: unixodbc

virtuoso-setup-password:
  cmd.wait:
    - name: echo set password dba {{ grains['virtuoso_password'] }}|isql "VOS" dba dba
    - creates: /etc/virtuoso-opensource-7/secured
    - watch:
      - {{ grains['service_provider'] }}: virtuoso-server

mark-virtuoso-secured:
  cmd.wait:
    - name: echo 1 > /etc/virtuoso-opensource-7/secured
    - watch:
      - cmd: virtuoso-setup-password

properties-virtuoso-tmp-config:
  file.append:
    - name: /usr/local/etc/subsite/subsite.tmp.ini
    - makedirs: True
    - text:
      - "sparql.host=localhost"
      - "sparql.port=8890"
      - "sparql.user=dba"
      - "sparql.dsn=VOS"
      - "sparql.password={{ grains['virtuoso_password'] }}"



{% if grains['provider'] == 'docker' %}
clean-virtuoso-shutdown:
  {{ grains['service_provider'] }}.dead:
    - name: virtuoso-opensource-7
    - require:
      - cmd: virtuoso-setup-password

/etc/supervisor/conf.d/virtuoso-opensource-7.conf:
    file.managed:
      - source: salt://virtuoso-opensource-7/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
      - require_in:
        - {{ grains['service_provider'] }}: virtuoso-server

{% endif %}

