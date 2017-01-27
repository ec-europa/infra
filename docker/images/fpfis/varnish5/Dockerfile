FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh https://repo.ne-dev.eu/el/6/fpfis-repo-6-1.el6.src.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y varnish varnish-modules vmod-drupal7

CMD /usr/sbin/varnishd -p vcl_dir=/srv/vcl -F -f /srv/vcl/testing.vcl -n /tmp
