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
  'site_type:subsite':
    - match: grain
    - solr5
  'site_type:joinup':
    - match: grain
    - virtuoso-opensource-7
  'provider:ec2':
    - match: grain
    - aws

