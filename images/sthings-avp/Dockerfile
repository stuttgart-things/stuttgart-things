ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.0-alpine3.18

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
# Switch to root for the ability to perform install

LABEL version=1.16.1
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
ENV AVP_VERSION=1.16.1
ENV BIN=argocd-vault-plugin
RUN curl -L -o ${BIN} https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64
RUN chmod +x ${BIN}
RUN mv ${BIN} /usr/local/bin

# Switch back to non-root user
USER 65532