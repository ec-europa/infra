base:
  '*':
    - apache2
    - php5
    - mysql
    - virtuoso
    - solr
    - mailcatcher
  'provider:ec2'
    - match: grain
    - aws
