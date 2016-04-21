solr-stack:
  pkg.installed:
    - pkgs:
      - solr-tomcat

/etc/solr/conf/solrconfig.xml:
  file.managed:
    - source: salt://solr/solrconfig.xml
    - require:
      - pkg: solr-stack

/etc/solr/conf/schema.xml:
  file.managed:
    - source: salt://solr/schema.xml
    - require:
      - pkg: solr-stack