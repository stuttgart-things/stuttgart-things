ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.17.3-python

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG ANSIBLE_VERSION=8.0.0
ENV USER_ID=65532
ENV GROUP_ID=65532

# OS + PIP PACKAGES
RUN apk add --no-cache git

RUN /usr/local/bin/python -m pip install --upgrade pip && pip install pip --upgrade
RUN pip install --no-cache-dir cryptography hvac "hvac[parser]" jmespath openshift kubernetes boto3 passlib kubernetes-validate proxmoxer netaddr setuptools requests pyVim PyVmomi python.dateutil dnspython pycrypto pywinrm pytz ansible==${ANSIBLE_VERSION}

RUN mkdir -p /home/nonroot/.ansible && chown -R ${USER_ID}:${GROUP_ID} /home/nonroot/.ansible

ADD requirements.yaml /home/nonroot/requirements.yaml

USER 65532
RUN ansible-galaxy install -r /home/nonroot/requirements.yaml
