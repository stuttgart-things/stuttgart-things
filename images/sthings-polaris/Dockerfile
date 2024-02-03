ARG FROM_TAG=alpine3.19
FROM python:${FROM_TAG}
LABEL version=8.5.4

ARG POLARIS_VERSION=8.5.4

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

RUN wget -q https://github.com/FairwindsOps/polaris/releases/download/${POLARIS_VERSION}/polaris_linux_amd64.tar.gz \
    && tar xzfz polaris_linux_amd64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/polaris \
    && rm -rf polaris_linux_amd64.tar.gz