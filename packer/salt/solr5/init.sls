solr-stack:
  pkg.installed:
    - pkgs:
      - supervisor
      - unzip
      - openjdk-7-jre-headless

solr-server-downloaded:
  archive.extracted:
    - name: /opt/
    - source: https://www-eu.apache.org/dist/lucene/solr/5.5.0/solr-5.5.0.tgz
    - source_hash: sha1=cc71b919282678276a37d393892ade5ce3e10252
    - archive_format: tar
    - tar_options: v
    - user: nobody
    - group: nobody
    - if_missing: /opt/solr-5.5.0/

drupal-solr-config-downloaded:
  archive.extracted:
    - name: /opt/
    - source: https://ftp.drupal.org/files/projects/search_api_solr-7.x-1.10.tar.gz
    - source_hash: sha256=08fe84bf82a89673d64f4f3fd499e3adeff6e88d03b7b60c673be107c3f932fb
    - archive_format: tar
    - tar_options: v
    - user: nobody
    - group: nobody
    - if_missing: /opt/search_api_solr
    - require:
      - archive: solr-server-downloaded

/opt/solr-5.5.0/server/solr/drupal/conf:
  file.directory:
    - user: nobody
    - group: nobody
    - mode: 755
    - makedirs: True
    - require:
      - archive: solr-server-downloaded

drupal-solr-config-installed:
  cmd.wait:
    - name: rsync -avz /opt/search_api_solr/solr-conf/5.x/  /opt/solr-5.5.0/server/solr/drupal/conf/
    - creates: /opt/solr-5.5.0/server/solr/drupal/conf/schema.xml
    - watch:
      - archive: drupal-solr-config-downloaded
    - require:
      - file: /opt/solr-5.5.0/server/solr/drupal/conf

solr-supervisor-config-installed:
  file.managed:
    - name: /etc/supervisor/conf.d/solr5.conf
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
    - name: /opt/solr-5.5.0/bin/solr create_core -c drupal
    - watch:
      - supervisord: solr-server-running
