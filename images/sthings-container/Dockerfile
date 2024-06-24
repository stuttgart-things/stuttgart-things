ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine
ARG TAG=3.12.2-alpine3.19

FROM gcr.io/kaniko-project/executor:v1.23.1 AS kaniko

FROM ${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
ARG SKOPEO_VERSION=1.14.4
ARG TRIVY_VERSION=0.52.2

COPY --from=kaniko /kaniko/ /kaniko/

ENV PATH $PATH:/usr/local/bin:/kaniko
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json
ENV SSL_CERT_DIR /kaniko/ssl/certs

RUN wget https://github.com/lework/skopeo-binary/releases/download/v${SKOPEO_VERSION}/skopeo-linux-amd64 \
    && mv skopeo-linux-amd64 /usr/bin/skopeo \
    && chmod +x /usr/bin/skopeo

RUN cd /tmp && wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
    && tar xvfz /tmp/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
    && mv /tmp/trivy /usr/bin/trivy \
    && chmod +x /usr/bin/trivy

ENTRYPOINT ["/kaniko/executor"]


/kaniko/executor --dockerfile Dockerfile \
--context git://github.com/stuttgart-things/stuttgart-things \
--context-sub-path images/sthings-alpine \
--no-push \
--tar-path /tmp/bla.tar

skopeo login scr.cd43.sthings-pve.labul.sva.de -u admin -p Atlan7is2023

skopeo --insecure-policy copy -f oci tarball:/tmp/bla.tar docker://scr.cd43.sthings-pve.labul.sva.de/crossplane-demo/test:v1
