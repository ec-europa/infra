base:
  'provider:docker':
    - match: grain
    - supervisor-docker
  '*':
    - common
    - apache2
    - php5
    - mysql
    - mailcatcher
    - solr5
  'site_type:joinup':
    - match: grain
    - virtuoso-opensource-7
  'provider:ec2':
    - match: grain
    - aws

