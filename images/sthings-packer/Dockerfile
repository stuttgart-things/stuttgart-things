ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-ansible
ARG TAG=10.1.0

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=1.10.3-9.5.1

# USER
USER root

ARG PACKER_VERSION=1.10.3
ARG MACHINE_SHOP_VERSION=v1.7.0
ARG GOVC_VERSION=0.37.1
RUN apk add --no-cache alpine-sdk build-base apk-tools alpine-conf busybox fakeroot syslinux xorriso squashfs-tools sudo mtools dosfstools grub-efi

# PACKER
RUN wget -O packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer.zip -d /usr/bin/ \
       && rm packer.zip

# GOVC
RUN wget -q https://github.com/vmware/govmomi/releases/download/v${GOVC_VERSION}/govc_Linux_x86_64.tar.gz \
    && tar xzfz govc_Linux_x86_64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/govc \
    && rm -rf govc_Linux_x86_64.tar.gz

# MACHINE-SHOP
RUN wget -q https://github.com/stuttgart-things/machineShop/releases/download/${MACHINE_SHOP_VERSION}/machineShop_Linux_x86_64.tar.gz \
    && tar -xvf machineShop_Linux_x86_64.tar.gz -C /usr/bin/ machineShop \
    && rm -rf machineShop_Linux_x86_64.tar.gz

# CREATE WORKDIR FOR GITHUB WORKFLOWS
RUN mkdir -m 1777 /__w
