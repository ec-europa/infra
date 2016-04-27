mysql-server:
  pkg.installed


mysql-service:
  service.running:
    - name: mysql

mysql_set_root_pw:
  mysql_user.present:
    - name: root
    - host: "%"
    - password: "{{ grains['mysql_password'] }}"
    - require:
      - service: mysql-service
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



/usr/local/etc/subsite/subsite.tmp.ini:
  file.append:
    - makedirs: True
    - text: "drupal.db.host: localhost"
    - text: "drupal.db.name: subsite"
    - text: "drupal.db.user: root"
    - text: "drupal.db.password: {{ grains['mysql_password'] }}"
