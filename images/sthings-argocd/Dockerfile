ARG REGISTRY=quay.io
ARG REPOSITORY=argoproj
ARG IMAGE=argocd
ARG TAG=v2.11.3

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL version=v2.8.6
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG ARGOCD_VAULT_PLUGIN_VERSION=1.16.1

# SWITCH TO ROOT FOR THE ABILITY TO PERFORM INSTALL
USER root

# INSTALL TOOLS NEEDED FOR YOUR REPO-SERVER TO RETRIEVE & DECRYPT SECRETS, RENDER MANIFESTS
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        gawk \
        awscli \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# INSTALL THE AVP PLUGIN (AS ROOT SO WE CAN COPY TO /USR/LOCAL/BIN)
RUN curl -L -o argocd-vault-plugin https://github.com/IBM/argocd-vault-plugin/releases/download/v${ARGOCD_VAULT_PLUGIN_VERSION}/argocd-vault-plugin_${ARGOCD_VAULT_PLUGIN_VERSION}_linux_amd64
RUN chmod +x argocd-vault-plugin
RUN mv argocd-vault-plugin /usr/local/bin

# VAULT CERTS
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://vault-pve.labul.sva.de:8200
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE}/v1/pki/ca/pem --no-check-certificate \
    && update-ca-certificates

# Switch back to non-root user
USER 999