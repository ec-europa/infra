FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh https://repo.ne-dev.eu/el/6/fpfis-repo-6-1.el6.src.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y httpd php70e-7.0.14 mod_php70e php70e-gd php70e-cli php70e-imap php70e-intl php70e-ldap php70e-mbstring php70e-mcrypt php70e-mysqlnd  php70e-opcache php70e-pdo php70e-soap php70e-xml php70e-pgsql
ADD envvars /etc/httpd/envvars
CMD bash -c "source /etc/httpd/envvars && exec /usr/sbin/httpd -d /usr/lib64/httpd -f /etc/httpd/conf/httpd.conf -DFOREGROUND"
