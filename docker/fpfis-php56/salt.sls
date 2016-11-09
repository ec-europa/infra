yum:
  pkg.latest

epel-release:
  pkgrepo.managed:
    - name: epel
    - humanname: CentOS-$releasever - Base
    - mirrorlist: http://mirrors.fedoraproject.org/mirrorlist?repo=epel-{{ grains['osmajorrelease'] }}&arch=$basearch
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-{{ grains['osmajorrelease'] }}

edge-release:
  # repository :
  pkgrepo.managed:
    - humanname: {{ grains['os'] }}-$releasever - Edge repo
    - baseurl: http://repo.siwhine.net/{{ grains['os']|lower() }}-{{ grains['osmajorrelease'] }}
    - gpgcheck: 1
    - gpgkey: http://repo.siwhine.net/EDGE-REPO-KEY.pub
    - require:
      - pkg: yum

php-stack-packages:
  pkg.installed:
    - pkgs:
      - httpd
      - php
      - php-gd
      - php-json
      - php-mysql
      - php-imap
