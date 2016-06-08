base:
  'provider:docker':
    - match: grain
    - supervisor-docker
  '*':
    - common
    - apache2
    - composer
    - mysql
    - mailcatcher
    - solr5
  'site_type:subsite':
    - match: grain
    - php5
  'site_type:joinup':
    - match: grain
    - php7-fpm
    - virtuoso-opensource-7
  'provider:ec2':
    - match: grain
    - aws

