FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://repo.siwhine.net/el/6/edge-repo-latest.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y httpd php71e-7.1.0 mod_php71e php71e-gd php71e-cli php71e-imap php71e-intl php71e-ldap php71e-mbstring php71e-mcrypt php71e-mysqlnd  php71e-opcache php71e-pdo php71e-soap php71e-xml php71e-pgsql && yum clean all
ADD envvars /etc/httpd/envvars
CMD bash -c "source /etc/httpd/envvars && exec /usr/sbin/httpd -d /usr/lib64/httpd -f /etc/httpd/conf/httpd.conf -DFOREGROUND"
