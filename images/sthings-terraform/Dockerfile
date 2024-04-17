FROM docker.io/library/ubuntu:22.04@sha256:0bced47fffa3361afa981854fcabcd4577cd43cebbb808cea2b1f33a3dd7f508

LABEL version=1.8.1
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# SWITCH TO ROOT FOR THE ABILITY TO PERFORM INSTALL
USER root

ARG DEBIAN_FRONTEND=noninteractive
ARG TERRAFORM_VERSION=1.8.1

# INSTALL TOOLS NEEDED FOR YOUR REPO-SERVER TO RETRIEVE & DECRYPT SECRETS, RENDER MANIFESTS
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        git \
        gawk \
        unzip \
        awscli \
        python3-pip \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# INSTALL TERRAFORM
RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform.zip -d /usr/bin/ \
       && rm terraform.zip
