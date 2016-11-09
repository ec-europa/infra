FROM centos:6
MAINTAINER Gregory Boddin

RUN yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el6.noarch.rpm 
RUN yum install -y salt-minion
COPY salt.sls /srv/salt/build.sls
RUN yum -y update
RUN salt-call -l info --local state.sls build
