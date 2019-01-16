# To build this Dockerfile:
#
# From the root of configuration:
#
# docker build -f docker/build/credentials/Dockerfile .
#
# This allows the dockerfile to update /edx/app/edx_ansible/edx_ansible
# with the currently checked-out configuration repo.

ARG BASE_IMAGE_TAG=latest
FROM edxops/xenial-common:${BASE_IMAGE_TAG}
MAINTAINER edxops
USER root
CMD ["/edx/app/supervisor/venvs/supervisor/bin/supervisord", "-n", "--configuration", "/edx/app/supervisor/supervisord.conf"]

# Dockerize will be useful to wait for mysql DB availability
ENV DOCKERIZE_VERSION v0.6.1
RUN curl -L -o dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize.tar.gz \
    && rm dockerize.tar.gz

ADD . /edx/app/edx_ansible/edx_ansible
WORKDIR /edx/app/edx_ansible/edx_ansible/docker/plays

COPY docker/build/credentials/ansible_overrides.yml /
COPY docker/build/devstack/ansible_overrides.yml /devstack/ansible_overrides.yml

ARG OPENEDX_RELEASE=master
ENV OPENEDX_RELEASE=${OPENEDX_RELEASE}
RUN sudo /edx/app/edx_ansible/venvs/edx_ansible/bin/ansible-playbook credentials.yml \
    -c local -i "127.0.0.1," \
    -t "install,assets,devstack" \
    --extra-vars="CREDENTIALS_VERSION=${OPENEDX_RELEASE}" \
    --extra-vars="@/ansible_overrides.yml" \
    --extra-vars="@/devstack/ansible_overrides.yml"

RUN  bash -c 'source /edx/app/credentials/credentials_env && cd /edx/app/credentials/credentials && make static' -- credentials

EXPOSE 18150
