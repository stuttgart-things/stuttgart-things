FROM quay.io/ansible/awx-ee:24.5.0
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=23.6.0

# VAULT INGRESS
ARG VAULT_URL_LABUL=https://vault.labul.sva.de:8200
ARG VAULT_URL_LABDA=https://vault.tiab.labda.sva.de:8200
ARG VAULT_URL_LABUL_VSPHERE=https://vault-vsphere.labul.sva.de:8200
ARG VAULT_URL_LABUL_PVE=https://vault-pve.labul.sva.de:8200
ARG VAULT_URL_LABDA_VSPHERE=https://vault-vsphere.tiab.labda.sva.de:8200

USER root
# RUN python3 --version
RUN dnf -y install wget python3-requests sudo
RUN pip3 install hvac
RUN rm -rf /etc/pki/ca-trust/source/anchors/* \
    && wget -O /etc/pki/ca-trust/source/anchors/labul-ca.crt ${VAULT_URL_LABUL}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /etc/pki/ca-trust/source/anchors/labda-ca.crt ${VAULT_URL_LABDA}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /etc/pki/ca-trust/source/anchors/labul-vsphere-ca.crt ${VAULT_URL_LABUL_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /etc/pki/ca-trust/source/anchors/labda-vsphere-ca.crt ${VAULT_URL_LABDA_VSPHERE}/v1/pki/ca/pem --no-check-certificate \
    && wget -O /etc/pki/ca-trust/source/anchors/labul-pve.crt ${VAULT_URL_LABUL_PVE}/v1/pki/ca/pem --no-check-certificate \
    && update-ca-trust

USER 1000
