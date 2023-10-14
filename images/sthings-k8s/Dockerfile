ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.17.3-python

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"
LABEL version=1.28.2

ARG KUBECTL_VERSION=1.28.2
ARG HELM_VERSION=3.13.1
ARG TKN_VERSION=0.32.0

# INSTALL KUBECTL + HELM
RUN apk add --no-cache ca-certificates bash git openssh curl libc6-compat \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && chmod g+rwx /root \
    && mkdir /config \
    && chmod g+rwx /config \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update

# INSTALL TEKTON CLI
RUN wget -q https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/tkn_${TKN_VERSION}_Linux_x86_64.tar.gz \
    && tar -xvf tkn_${TKN_VERSION}_Linux_x86_64.tar.gz -C /usr/bin/ tkn \
    && rm -rf tkn_${TKN_VERSION}_Linux_x86_64.tar.gz
