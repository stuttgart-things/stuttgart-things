ARG REGISTRY=quay.io
ARG REPOSITORY=argoproj
ARG IMAGE=argocd
ARG TAG=v2.12.3
FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=v2.12.3

# SWITCH TO ROOT FOR THE ABILITY TO PERFORM INSTALL
USER root

# INSTALL TOOLS NEEDED FOR YOUR REPO-SERVER TO RETRIEVE & DECRYPT SECRETS, RENDER MANIFESTS
RUN apt-get update -y && \
    apt-get install -y \
        curl \
        wget \
        python3-pip \
        gawk \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN pip install awscli --break-system-packages

# INSTALL VAULT CERTS
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
#ARG VAULT_URL_LABUL_PVE=https://vault-pve.labul.sva.de:8200
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200
RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    #&& wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE}/v1/pki/ca/pem --no-check-certificate \
    && update-ca-certificates

# SWITCH BACK TO NON-ROOT USER
USER 999