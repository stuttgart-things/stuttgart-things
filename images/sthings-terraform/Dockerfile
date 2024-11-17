ARG REGISTRY=ghcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.9.20-alpine3.20
FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

# META INFORMATION
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=1.9.8

# VERSIONS
ARG TERRAFORM_VERSION=1.9.8 # datasource=custom.hashicorp
ARG YQ_VERSION=4.44.5
ARG MACHINE_SHOP_VERSION=2.6.3

# INSTALL OS PACKAGES
RUN apk add --no-cache aws-cli \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# VAULT INSTANCES
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://raw.githubusercontent.com/stuttgart-things/stuttgart-things/main/images/sthings-alpine/labul-pve.crt
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

# INSTALL VAULT CERTS
RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE} \
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
