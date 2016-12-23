FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://repo.siwhine.net/el/6/edge-repo-latest.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y httpd php56e-5.6.29 mod_php56e php56e-gd php56e-cli php56e-imap php56e-intl php56e-ldap php56e-mbstring php56e-mcrypt php56e-mssql php56e-mysqlnd  php56e-opcache php56e-pdo php56e-soap php56e-xml php56e-pgsql && yum clean all
ADD envvars /etc/httpd/envvars
CMD bash -c "source /etc/httpd/envvars && exec /usr/sbin/httpd -d /usr/lib64/httpd -f /etc/httpd/conf/httpd.conf -DFOREGROUND"
