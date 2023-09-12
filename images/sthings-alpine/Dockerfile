ARG FROM_TAG=3.11.4-alpine3.18
FROM python:${FROM_TAG}

LABEL version=3.11.4-alpine3.18
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra

# VAULT LEGACY
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200

# VAULT INGRESS
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

# INSTALL OS PACKAGES
RUN apk add --no-cache build-base sudo gawk libc6-compat openssl libffi-dev openssl-dev openssh sshpass tar unzip jq curl ca-certificates wget \
   && apk add --update bash \
       && rm -rf /var/cache/apk/*

# install glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
   && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk \
       && apk add --force-overwrite glibc-2.35-r0.apk \
       && rm -rf glibc-2.35-r0.apk

# CREATE NON ROOT USER
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
