ARG REGISTRY=ghcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.9.20-alpine3.20
FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

# SET META INFORMATION
LABEL version=11.0.0
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# SW VERSIONS
ARG YQ_VERSION=4.44.5
ARG ANSIBLE_VERSION=11.0.0
ARG ANSIBLE_LINT_VERSION=24.10.0
ARG MACHINE_SHOP_VERSION=2.6.6

ENV USER_ID=65532
ENV GROUP_ID=65532

# OS + PIP PACKAGES
RUN apk add --no-cache git

# YQ
RUN wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64.tar.gz \
    && tar xvfz yq_linux_amd64.tar.gz -C /usr/bin \
    && mv /usr/bin/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf xvfz yq_linux_amd64.tar.gz

# MACHINESHOP
RUN wget -q https://github.com/stuttgart-things/machineshop/releases/download/v${MACHINE_SHOP_VERSION}/machineshop_Linux_x86_64.tar.gz \
    && tar -xvf machineshop_Linux_x86_64.tar.gz -C /usr/bin/ machineshop \
    && rm -rf machineshop_Linux_x86_64.tar.gz

# GET RUST; NOTE: USING SH FOR BETTER COMPATIBILITY WITH OTHER BASE IMAGES
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN /usr/local/bin/python -m pip install --upgrade pip && pip install pip --upgrade
RUN pip install --no-cache-dir cryptography hvac "hvac[parser]" paramiko jmespath openshift kubernetes boto3 passlib kubernetes-validate==1.27.0 proxmoxer netaddr setuptools requests pyVim PyVmomi python.dateutil dnspython pycrypto pywinrm pytz ansible==${ANSIBLE_VERSION} ansible-lint==${ANSIBLE_LINT_VERSION}
RUN mkdir -p /home/nonroot/.ansible && chown -R ${USER_ID}:${GROUP_ID} /home/nonroot/.ansible

# ANSIBLE REQUIREMENTS
ADD requirements.yaml /home/nonroot/requirements.yaml
USER 65532
RUN ansible-galaxy install -r /home/nonroot/requirements.yaml
USER root
