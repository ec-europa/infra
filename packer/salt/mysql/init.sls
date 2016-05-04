mysql-server:
  pkg.installed


mysql-service:
  {{ grains['service_provider'] }}.running:
    - update: true
    - name: mysql

mysql_set_root_pw:
  mysql_user.present:
    - name: root
    - host: "%"
    - password: "{{ grains['mysql_password'] }}"
    - require:
      - {{ grains['service_provider'] }}: mysql-service
    - connection_default_file: /etc/mysql/debian.cnf

mysql_set_root_pw_grants:
   mysql_grants.present:
    - grant: ALL
    - database: "*.*"
    - user: root
    - host: "%"
    - require:
      - mysql_user: mysql_set_root_pw
    - connection_default_file: /etc/mysql/debian.cnf

drop_empty_passwords:
  mysql_query.run:
    - database: mysql
    - query:    "DELETE FROM mysql.user where Password = ''; FLUSH PRIVILEGES;"
    - connection_default_file: /etc/mysql/debian.cnf
    - require:
      - mysql_grants: mysql_set_root_pw_grants

properties-mysql-tmp-config:
  file.append:
    - name: /usr/local/etc/subsite/subsite.tmp.ini
    - makedirs: True
    - text:
      - "drupal.db.host=localhost"
      - "drupal.db.name=subsite"
      - "drupal.db.user=root"
      - "drupal.db.password={{ grains['mysql_password'] }}"

{% if grains['provider'] == 'docker' %}
/etc/supervisor/conf.d/mysql.conf:
    file.managed:
      - source: salt://mysql/supervisor.conf
      - require:
        - pkg: supervisor-docker-stack
      - require_in:
        - {{ grains['service_provider'] }}: mysql-service
{% endif %}