    {% from "solr5/map.jinja" import solr5_settings with context %}

solr-stack:
  pkg.installed:
    - pkgs:
      - supervisor
      - unzip
      - openjdk-7-jre-headless

solr-server-downloaded:
  archive.extracted:
    - name: /opt/
    - source: http://www-eu.apache.org/dist/lucene/solr/{{ solr5_settings.version }}/solr-{{ solr5_settings.version }}.tgz
    - source_hash: sha1={{ solr5_settings.sha1 }}
    - archive_format: tar
    - user: nobody
    - group: nogroup
    - if_missing: /opt/solr-{{ solr5_settings.version }}/

drupal-solr-config-downloaded:
  archive.extracted:
    - name: /opt/
    - source: https://ftp-origin.drupal.org/files/projects/search_api_solr-7.x-1.10.tar.gz
    - source_hash: sha256=08fe84bf82a89673d64f4f3fd499e3adeff6e88d03b7b60c673be107c3f932fb
    - archive_format: tar
    - user: nobody
    - group: nogroup
    - if_missing: /opt/search_api_solr/
    - require:
      - archive: solr-server-downloaded

/opt/solr-{{ solr5_settings.version }}/server/solr/drupal/conf:
  file.directory:
    - user: nobody
    - group: nogroup
    - mode: 755
    - makedirs: True
    - require:
      - archive: solr-server-downloaded

drupal-solr-config-installed:
  cmd.wait:
    - name: rsync -avz /opt/search_api_solr/solr-conf/5.x/  /opt/solr-{{ solr5_settings.version }}/server/solr/drupal/conf/
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal/conf/schema.xml
    - watch:
      - archive: drupal-solr-config-downloaded
    - require:
      - file: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal/conf

solr-supervisor-config-installed:
  file.managed:
    - source: salt://solr5/supervisor.conf
    - name: /etc/supervisor/conf.d/solr5.conf
    - template: jinja
    - context:
      solr5_settings: {{ solr5_settings }}
    - require:
      - pkg: solr-stack

solr-server-running:
  supervisord.running:
    - name: solr5
    - update: true
    - require:
      - cmd: drupal-solr-config-installed

solr-drupal-core-enabled:
  cmd.wait:
    - name: sleep 15 && /opt/solr-{{ solr5_settings.version }}/bin/solr create_core -c drupal
    - cwd: /opt/solr-{{ solr5_settings.version }}
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal/core.properties
    - watch:
      - supervisord: solr-server-running
