ARG FROM_TAG=3.12.6-alpine3.20
FROM python:${FROM_TAG}

# META INFORMATION
LABEL version=3.9.20-alpine3.20
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL org.opencontainers.image.source https://github.com/stuttgart-things/stuttgart-things

# ENV VARIABLES
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://raw.githubusercontent.com/stuttgart-things/stuttgart-things/main/images/sthings-alpine/labul-pve.crt
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

# INSTALL CA CERTIFICATES
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra

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

# INSTALL GLIBC
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
   && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk \
       && apk add --force-overwrite glibc-2.35-r0.apk \
       && rm -rf glibc-2.35-r0.apk

# CREATE NONROOT USER
ENV USER_ID=65532
ENV GROUP_ID=65532
ENV USER_NAME=nonroot
ENV GROUP_NAME=nonroot
ENV USER_HOME=/home/nonroot
RUN addgroup -g $GROUP_ID $GROUP_NAME && \
     adduser --shell /bin/bash --disabled-password -h ${USER_HOME} \
     --uid $USER_ID --ingroup $GROUP_NAME $USER_NAME

RUN mkdir -p /home/nonroot
RUN chown -R ${USER_ID}:${GROUP_ID} ${USER_HOME}
