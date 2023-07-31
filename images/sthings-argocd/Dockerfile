FROM quay.io/argoproj/argocd:v2.7.4

LABEL version=3.11.4-alpine3.18
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG ARGOCD_VAULT_PLUGIN_VERSION=1.14.0

# Switch to root for the ability to perform install
USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        awscli \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
RUN curl -L -o argocd-vault-plugin https://github.com/IBM/argocd-vault-plugin/releases/download/v${ARGOCD_VAULT_PLUGIN_VERSION}/argocd-vault-plugin_${ARGOCD_VAULT_PLUGIN_VERSION}_linux_amd64
RUN chmod +x argocd-vault-plugin
RUN mv argocd-vault-plugin /usr/local/bin

# VAULT LEGACY
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
# VAULT INGRESS
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://vault-pve.labul.sva.de:8200
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

# vault certs
RUN rm -rf /usr/local/share/ca-certificates/* \
    && wget -O /usr/local/share/ca-certificates/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /usr/local/share/ca-certificates/labul-pve.crt ${VAULT_URL_LABUL_PVE}/v1/pki/ca/pem --no-check-certificate \
    && update-ca-certificates

# Switch back to non-root user
USER 999