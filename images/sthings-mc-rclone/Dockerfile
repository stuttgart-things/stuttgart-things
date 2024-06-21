ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.2-alpine3.19

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL version=2024-05-14

ARG MC_VERSION=RELEASE.2024-05-09T17-04-24Z
ARG RCLONE_VERSION=v1.66.0

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc.${MC_VERSION} \
    && mv mc.${MC_VERSION} mc \
    && chmod +x mc \
    && mv mc /usr/bin/

RUN wget -q https://downloads.rclone.org/v1.66.0/rclone-${RCLONE_VERSION}-linux-amd64.zip \
    && unzip rclone-${RCLONE_VERSION}-linux-amd64.zip \
    && mv rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/bin/rclone \
    && chmod +x /usr/bin/rclone \
    && rm -rf clone-${RCLONE_VERSION}-linux-amd64.zip rclone-${RCLONE_VERSION}-linux-amd64
