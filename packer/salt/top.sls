base:
  '*':
    - apache2
    - php5
    - mysql
    - virtuoso-opensource-7
    - solr
    - mailcatcher
  'provider:ec2':
    - match: grain
    - aws
