ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.1-alpine3.19

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=2024-02-13
ARG MC_VERSION=RELEASE.2024-02-13T15-35-11Z

RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio.${MC_VERSION} \
    && mv minio.${MC_VERSION} mc \
    && chmod +x mc \
    && mv mc /usr/bin/
