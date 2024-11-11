ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=alpine-3.20-1
FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

# SET META INFORMATION
LABEL version=10.4.0
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# OS + PIP PACKAGES
RUN apk update && apk add --no-cache curl git bash \
    && curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" |sh \
    && mv crossplane /usr/bin/
