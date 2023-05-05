ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.17.3-python

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG ANSIBLE_VERSION=7.5.0

# OS + PIP PACKAGES
RUN /usr/local/bin/python -m pip install --upgrade pip && pip install pip --upgrade
RUN pip install --no-cache-dir cryptography hvac "hvac[parser]" jmespath openshift kubernetes boto3 passlib kubernetes-validate proxmoxer netaddr setuptools requests pyVim PyVmomi python.dateutil dnspython pycrypto pywinrm pytz ansible==${ANSIBLE_VERSION}

ADD requirements.yaml /home/nonroot/requirements.yaml

RUN ansible-galaxy install -r /home/nonroot/requirements.yaml