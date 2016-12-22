FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm 
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y mysql-community-server

CMD /bin/true 
