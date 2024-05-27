ARG FROM_TAG=3.12.3-alpine3.19
FROM python:${FROM_TAG}
LABEL version=9.0.1-3.12.3-1

ARG POLARIS_VERSION=9.0.1

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# INSTALL OS PACKAGES
RUN apk add --no-cache build-base sudo gawk libc6-compat openssl libffi-dev openssl-dev openssh sshpass tar unzip jq curl ca-certificates wget \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# POLARIS
RUN wget -q https://github.com/FairwindsOps/polaris/releases/download/${POLARIS_VERSION}/polaris_linux_amd64.tar.gz \
&& tar xzfz polaris_linux_amd64.tar.gz -C /usr/bin \
&& chmod +x /usr/bin/polaris \
&& rm -rf polaris_linux_amd64.tar.gz

COPY requirements.txt .
RUN python3 -m venv venv

RUN pip install --no-cache-dir -r requirements.txt