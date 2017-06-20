/opt/solr-{{ solr5_settings.version }}/server/solr/drupal_published/conf:
  file.directory:
    - user: nobody
    - group: nogroup
    - mode: 755
    - makedirs: True
    - require:
      - archive: solr-server-downloaded

/opt/solr-{{ solr5_settings.version }}/server/solr/drupal_unpublished/conf:
  file.directory:
    - user: nobody
    - group: nogroup
    - mode: 755
    - makedirs: True
    - require:
      - archive: solr-server-downloaded

drupal_published-solr-config-installed:
  cmd.wait:
    - name: rsync -avz /opt/search_api_solr/solr-conf/5.x/  /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_published/conf/
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_published/conf/schema.xml
    - watch:
      - archive: drupal-solr-config-downloaded
    - require:
      - file: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_published/conf

drupal_unpublished-solr-config-installed:
  cmd.wait:
    - name: rsync -avz /opt/search_api_solr/solr-conf/5.x/  /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_unpublished/conf/
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_unpublished/conf/schema.xml
    - watch:
      - archive: drupal-solr-config-downloaded
    - require:
      - file: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_unpublished/conf

solr-drupal_published-core-enabled:
  cmd.wait:
    - name: sleep 15 && /opt/solr-{{ solr5_settings.version }}/bin/solr create_core -c drupal_published
    - cwd: /opt/solr-{{ solr5_settings.version }}
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_published/core.properties
    - watch:
      - supervisord: solr-server-running

solr-drupal_unpublished-core-enabled:
  cmd.wait:
    - name: sleep 15 && /opt/solr-{{ solr5_settings.version }}/bin/solr create_core -c drupal_unpublished
    - cwd: /opt/solr-{{ solr5_settings.version }}
    - creates: /opt/solr-{{ solr5_settings.version }}/server/solr/drupal_unpublished/core.properties
    - watch:
      - supervisord: solr-server-running