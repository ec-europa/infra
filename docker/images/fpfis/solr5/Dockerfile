FROM centos:6
MAINTAINER Gregory Boddin

RUN rpm -Uvh http://repo.siwhine.net/el/6/edge-repo-latest.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y java-1.8.0-openjdk wget && wget "http://apache.crihan.fr/dist/lucene/solr/5.5.3/solr-5.5.3.tgz" -O /opt/solr.tgz && cd /opt && tar -xzvf solr.tgz && rm solr.tgz && mv /opt/solr-5.5.3 /opt/solr && yum clean all
ADD cores/d7_search_api /opt/solr/server/solr/d7_search_api/conf
ADD cores/d7_apachesolr /opt/solr/server/solr/d7_apachesolr/conf
RUN /opt/solr/bin/solr start && sleep 1 && \
    /opt/solr/bin/solr create_core -c d7_search_api && \
    /opt/solr/bin/solr create_core -c d7_apachesolr &&  \
    /opt/solr/bin/solr stop
CMD /opt/solr/bin/solr start -f
