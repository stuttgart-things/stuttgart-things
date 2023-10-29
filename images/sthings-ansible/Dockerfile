ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.13.0a1-alpine3.18

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=8.5.0

ARG FLUX_VERSION=2.1.1
ARG YQ_VERSION=4.35.2

ARG ANSIBLE_VERSION=8.5.0
ENV USER_ID=65532
ENV GROUP_ID=65532

# OS + PIP PACKAGES
RUN apk add --no-cache git

# FLUX CLI
RUN wget -q https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_amd64.tar.gz \
    && tar xvfz flux_${FLUX_VERSION}_linux_amd64.tar.gz -C /usr/bin \
    && chmod +x /usr/bin/flux \
    && rm -rf flux_${FLUX_VERSION}_linux_amd64.tar.gz

# YQ
RUN wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64.tar.gz \
    && tar xvfz yq_linux_amd64.tar.gz -C /usr/bin \
    && mv /usr/bin/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf xvfz yq_linux_amd64.tar.gz

# Get Rust; NOTE: using sh for better compatibility with other base images
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# Add .cargo/bin to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

RUN /usr/local/bin/python -m pip install --upgrade pip && pip install pip --upgrade
RUN pip install --no-cache-dir cryptography hvac "hvac[parser]" paramiko jmespath openshift kubernetes boto3 passlib kubernetes-validate==1.27.0 proxmoxer netaddr setuptools requests pyVim PyVmomi python.dateutil dnspython pycrypto pywinrm pytz ansible==${ANSIBLE_VERSION}

RUN mkdir -p /home/nonroot/.ansible && chown -R ${USER_ID}:${GROUP_ID} /home/nonroot/.ansible

ADD requirements.yaml /home/nonroot/requirements.yaml

USER 65532
RUN ansible-galaxy install -r /home/nonroot/requirements.yaml
