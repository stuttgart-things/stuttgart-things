ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.11.4-alpine3.18

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=8.2.0-2

ARG FLUX_VERSION=2.0.1
ARG ANSIBLE_VERSION=8.2.0
ENV USER_ID=65532
ENV GROUP_ID=65532

# OS + PIP PACKAGES
RUN apk add --no-cache git

# FLUX CLI
RUN wget -q https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_amd64.tar.gz \
    && tar xvfz flux_${FLUX_VERSION}_linux_amd64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/flux \
    && rm -rf flux_${FLUX_VERSION}_linux_amd64.tar.gz

RUN /usr/local/bin/python -m pip install --upgrade pip && pip install pip --upgrade
RUN pip install --no-cache-dir cryptography hvac "hvac[parser]" jmespath openshift kubernetes boto3 passlib kubernetes-validate proxmoxer netaddr setuptools requests pyVim PyVmomi python.dateutil dnspython pycrypto pywinrm pytz ansible==${ANSIBLE_VERSION}

RUN mkdir -p /home/nonroot/.ansible && chown -R ${USER_ID}:${GROUP_ID} /home/nonroot/.ansible

ADD requirements.yaml /home/nonroot/requirements.yaml

USER 65532
RUN ansible-galaxy install -r /home/nonroot/requirements.yaml
