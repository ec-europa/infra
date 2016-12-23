FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm 
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum install -y yum-utils && yum-config-manager --disable mysql57-community && yum-config-manager --enable mysql56-community && yum clean all 
RUN yum install -y mysql-community-server && yum clean all
USER mysql
RUN mysql_install_db
CMD /usr/sbin/mysqld -u mysql --socket=/var/lib/mysql/mysql.sock --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --pid-file=/var/lib/mysql/mysql.pid 
