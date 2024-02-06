ARG FROM_TAG=alpine3.19
FROM python:${FROM_TAG}
LABEL version=8.5.4-3.14.0-1

ARG POLARIS_VERSION=8.5.4
ARG HELM_VERSION=3.14.0

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

RUN apk add --no-cache build-base sudo gawk libc6-compat openssl libffi-dev openssl-dev openssh sshpass lftp unzip jq curl ca-certificates wget \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# HELM
RUN wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xzfz helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && rm -rf linux-amd64

# POLARIS
RUN wget -q https://github.com/FairwindsOps/polaris/releases/download/${POLARIS_VERSION}/polaris_linux_amd64.tar.gz \
    && tar xzfz polaris_linux_amd64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/polaris \
    && rm -rf polaris_linux_amd64.tar.gz