ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.0-alpine3.18

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
# SWITCH TO ROOT FOR THE ABILITY TO PERFORM INSTALL

LABEL version=1.17.0-1
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ENV AWSCDK_VERSION=2.99.0
ENV GLIBC_VER=2.34-r0
ENV AVP_VERSION=1.17.0
ENV BIN=argocd-vault-plugin
# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)

RUN apk update && apk upgrade -i -a --update-cache && apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --force-overwrite --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
        curl \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
RUN wget https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64
RUN chmod +x ${BIN}*
RUN mv ${BIN}* /usr/local/bin/${BIN}

# CREATE NON ROOT USER
ENV USER_ID=999
ENV GROUP_ID=998
ENV USER_NAME=argocd
ENV GROUP_NAME=argocd
ENV USER_HOME=/home/argocd

RUN addgroup -g $GROUP_ID $GROUP_NAME && \
     adduser --shell /bin/bash --disabled-password -h ${USER_HOME} \
     --uid $USER_ID --ingroup $GROUP_NAME $USER_NAME

RUN mkdir -p /home/nonroot

RUN chown -R ${USER_ID}:${GROUP_ID} ${USER_HOME}

# Switch back to non-root user
USER 999