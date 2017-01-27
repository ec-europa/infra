FROM centos:6
MAINTAINER Gregory Boddin

RUN curl http://repo.ne-dev.eu/el/6/fpfis.repo > /etc/yum.repos.d/fpfis.repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y varnish varnish-modules vmod-drupal7

CMD /usr/sbin/varnishd -p vcl_dir=/srv/vcl -F -f /srv/vcl/testing.vcl -n /tmp
