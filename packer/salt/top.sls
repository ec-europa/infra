base:
  'provider:docker':
    - match: grain
    - supervisor-docker
  '*':
    - common
    - apache2
    - php5
    - mysql
    - solr
    - mailcatcher
  'site_type:joinup':
    - match: grain
    - virtuoso-opensource-7
  'provider:ec2':
    - match: grain
    - aws

