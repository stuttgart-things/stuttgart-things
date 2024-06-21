ARG FROM_TAG=alpine3.19
FROM python:${FROM_TAG}

LABEL version=3.12.3-alpine3.19-5.19.1

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG PLUTO_VERSION=5.19.1

RUN apk add --no-cache build-base sudo gawk libc6-compat openssl libffi-dev openssl-dev openssh unzip jq curl ca-certificates wget \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# PLUTO
RUN wget -q https://github.com/FairwindsOps/pluto/releases/download/v${PLUTO_VERSION}/pluto_${PLUTO_VERSION}_linux_amd64.tar.gz \
    && tar xzfz pluto_${PLUTO_VERSION}_linux_amd64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/pluto \
    && rm -rf pluto_linux_amd64.tar.gz