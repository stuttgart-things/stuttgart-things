ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.2-alpine3.19

FROM gcr.io/kaniko-project/executor:v1.23.2 AS kaniko

# META INFORMATION
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=1.23.2

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
ARG SKOPEO_VERSION=1.14.4 # datasource=github-tags depName=lework/skopeo-binary
ARG TRIVY_VERSION=0.52.2
ARG YQ_VERSION=4.44.2
ARG MACHINE_SHOP_VERSION=2.2.9
ARG JQ_VERSION=1.7.1

# COPY KANIKO BINARY TO TARGET IMAGE
COPY --from=kaniko /kaniko/ /kaniko/

ENV PATH $PATH:/usr/local/bin:/kaniko
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json
ENV SSL_CERT_DIR /kaniko/ssl/certs

RUN wget https://github.com/lework/skopeo-binary/releases/download/v${SKOPEO_VERSION}/skopeo-linux-amd64 \
    && mv skopeo-linux-amd64 /usr/bin/skopeo \
    && chmod +x /usr/bin/skopeo \
    && mkdir -p /etc/containers

ADD policy.json /etc/containers/policy.json

RUN cd /tmp && wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
    && tar xvfz /tmp/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
    && mv /tmp/trivy /usr/bin/trivy \
    && chmod +x /usr/bin/trivy

# MACHINE-SHOP
RUN wget -q https://github.com/stuttgart-things/machineshop/releases/download/${MACHINE_SHOP_VERSION}/machineshop_Linux_x86_64.tar.gz \
    && tar -xvf machineshop_Linux_x86_64.tar.gz -C /usr/bin/ machineshop \
    && rm -rf machineshop_Linux_x86_64.tar.gz

# INSTALL YQ
RUN wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64.tar.gz \
    && tar xvfz yq_linux_amd64.tar.gz -C /usr/bin \
    && mv /usr/bin/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf yq_linux_amd64.tar.gz

# INSTALL JQ
RUN wget -q https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64 \
    && mv jq-linux-amd64 /usr/bin/jq \
    && chmod +x /usr/bin/jq

ENTRYPOINT ["/kaniko/executor"]
