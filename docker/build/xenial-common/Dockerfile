FROM ubuntu:xenial
MAINTAINER edxops

# Set locale to UTF-8 which is not the default for docker.
# See the links for details:
# http://jaredmarkell.com/docker-and-locales/
# https://github.com/docker-library/python/issues/13
# https://github.com/docker-library/python/pull/14/files
RUN apt-get update &&\
    apt-get install -y locales &&\
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y openssl wget

ENV ANSIBLE_REPO="https://github.com/edx/ansible"
ENV CONFIGURATION_REPO="https://github.com/armbox/configuration.git"
ARG OPENEDX_RELEASE=master
ENV CONFIGURATION_VERSION="${OPENEDX_RELEASE}"

ADD util/install/ansible-bootstrap.sh /tmp/ansible-bootstrap.sh
RUN chmod +x /tmp/ansible-bootstrap.sh
RUN /tmp/ansible-bootstrap.sh

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
