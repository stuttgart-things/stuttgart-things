ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.1-alpine3.19

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=2024-02-09
ARG MC_VERSION=RELEASE.2024-02-09T22-18-24Z

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc.${MC_VERSION} \
    && mv mc.${MC_VERSION} mc \
    && chmod +x mc \
    && mv mc /usr/bin/