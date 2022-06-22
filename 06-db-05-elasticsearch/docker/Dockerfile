FROM centos:7

RUN yum -y update &&  \
    yum clean all &&  \
    yum -y install wget && \
    yum -y install perl-Digest-SHA && \
    yum -y install java-11-openjdk



RUN mkdir -p /opt/ && cd /opt/ && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.3-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 &&  \
    tar -xzf elasticsearch-8.2.3-linux-x86_64.tar.gz && rm -f elasticsearch-8.2.3-linux-x86_64.tar.gz \
    export https_proxy=""

RUN groupadd elasticsearch  && useradd elasticsearch -g elasticsearch -p elasticsearch

RUN chown -R elasticsearch:elasticsearch /opt/elasticsearch-8.2.3/ && \
    mkdir -p /var/log/elasticsearch && chown -R elasticsearch:elasticsearch /var/log/elasticsearch && \
    mkdir -p /var/lib/elasticsearch/data && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/data && \
    ln -s /opt/elasticsearch-8.2.3/bin/elasticsearch /usr/bin/elasticsearch

USER elasticsearch
ENV ES_PATH_CONF=/opt/elasticsearch-8.2.3/config/
CMD ["/opt/elasticsearch-8.2.3/bin/elasticsearch"]