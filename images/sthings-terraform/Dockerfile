FROM docker.io/library/ubuntu:24.04@sha256:2e863c44b718727c860746568e1d54afd13b2fa71b160f5cd9058fc436217b30

LABEL version=1.8.4-2
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# SWITCH TO ROOT FOR THE ABILITY TO PERFORM INSTALL
USER root

ARG DEBIAN_FRONTEND=noninteractive
ARG TERRAFORM_VERSION=1.8.4
ARG YQ_VERSION=4.43.1
ARG MACHINE_SHOP_VERSION=2.1.9

# INSTALL TOOLS NEEDED FOR YOUR REPO-SERVER TO RETRIEVE & DECRYPT SECRETS, RENDER MANIFESTS
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        jq \
        git \
        gawk \
        unzip \
        awscli \
        python3-pip \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VAULT INSTANCES
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://vault-pve.labul.sva.de:8200
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

# INSTALL VAULT CERTS
RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE}/v1/pki/ca/pem --no-check-certificate \
    && update-ca-certificates

# INSTALL TERRAFORM
RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform.zip -d /usr/bin/ \
       && rm terraform.zip

# MACHINE-SHOP
RUN wget -q https://github.com/stuttgart-things/machineshop/releases/download/${MACHINE_SHOP_VERSION}/machineshop_Linux_x86_64.tar.gz \
    && tar -xvf machineshop_Linux_x86_64.tar.gz -C /usr/bin/ machineshop \
    && rm -rf machineshop_Linux_x86_64.tar.gz

# INSTALL YQ
RUN wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64.tar.gz \
    && tar xvfz yq_linux_amd64.tar.gz -C /usr/bin \
    && mv /usr/bin/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf yq_linux_amd64.tar.gz

# INSTALL JQ
RUN wget -q https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 \
    && mv jq-linux-amd64 /usr/bin/jq \
    && chmod +x /usr/bin/jq
