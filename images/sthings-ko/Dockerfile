FROM ghcr.io/stuttgart-things/sthings-alpine:1.23@sha256:486b343e3bac3148e8f4608b11cf68da01493335724d6db2d4fb168bd394b9f0

ARG MACHINE_SHOP_VERSION=2.2.9

# ENV VARIABLES
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://raw.githubusercontent.com/stuttgart-things/stuttgart-things/main/images/sthings-alpine/labul-pve.crt
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

# INSTALL PACKAGES W/ APK
RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE} \
    && update-ca-certificates

# INSTALL OS PACKAGES W/ APK
RUN apk add --no-cache build-base sudo git gawk libc6-compat openssl libffi-dev openssl-dev openssh sshpass tar unzip jq curl ca-certificates wget \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# MACHINE-SHOP
RUN wget -q https://github.com/stuttgart-things/machineshop/releases/download/${MACHINE_SHOP_VERSION}/machineshop_Linux_x86_64.tar.gz \
    && tar -xvf machineshop_Linux_x86_64.tar.gz -C /usr/bin/ machineshop \
    && rm -rf machineshop_Linux_x86_64.tar.gz