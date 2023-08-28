ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-ansible
ARG TAG=8.3.0-8

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=1.9.4-8.3.0-8

USER root

ARG PACKER_VERSION=1.9.4

RUN apk add --no-cache alpine-sdk build-base apk-tools alpine-conf busybox fakeroot syslinux xorriso squashfs-tools sudo mtools dosfstools grub-efi

# PACKER
RUN wget -O packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer.zip -d /usr/bin/ \
       && rm packer.zip

USER 65532
