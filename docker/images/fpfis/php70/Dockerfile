FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://repo.siwhine.net/el/6/edge-repo-latest.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y httpd php70e-fpm php70e-cli php70e-pear 

CMD /bin/true 
