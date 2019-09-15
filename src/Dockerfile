ARG BASE
FROM ${BASE}

ENV DEBIAN_FRONTEND=noninteractive
ENV ES_HOME=/srv/elasticsearch

ARG ELASTIC_VERSION
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    perl \ 
    locales \
    wget \
 && locale-gen en_US.UTF-8 \
 && cd /srv \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 \
 && shasum -a 512 -c elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 \
 && tar -xzf elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
 && rm -rf elasticsearch-${ELASTIC_VERSION}-linux* \
 && mv elasticsearch-${ELASTIC_VERSION} elasticsearch \
 && chown -R www-data:www-data elasticsearch \
 && apt-get purge -y \
    perl \
 && apt-get autoremove -y \ 
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* 

USER www-data
VOLUME /srv/elasticsearch/config
EXPOSE 9300
ENTRYPOINT ["/srv/elasticsearch/bin/elasticsearch"]

ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE
LABEL org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.build-date=${BUILD_DATE}
