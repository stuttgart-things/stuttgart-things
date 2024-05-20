FROM golang:1.22.3 AS builder
LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

ARG VERSION=""
ARG BUILD_DATE=""
ARG COMMIT=""
ARG GIT_PAT=""
ARG MODULE="github.com/stuttgart-things/machineshop"
ARG REGISTRY=eu.gcr.io
ARG REPOSITORY=stuttgart-things
ARG IMAGE=sthings-alpine

WORKDIR /src/
COPY . .

RUN go mod tidy
RUN CGO_ENABLED=0 go build -buildvcs=false -o /bin/machineShop\
    -ldflags="-X ${MODULE}/cmd.version=${VERSION} -X ${MODULE}/cmd.date=${BUILD_DATE} -X ${MODULE}/cmd.commit=${COMMIT}"

FROM eu.gcr.io/stuttgart-things/sthings-alpine:3.12.2-alpine3.19
ARG YQ_VERSION=4.42.1
ARG GH_CLI_VERSION=2.47.0

LABEL maintainer="Patrick Hermann patrick.hermann@sva.de"

RUN apk add gawk git jq github-cli

RUN wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64.tar.gz \
    && tar xvfz yq_linux_amd64.tar.gz -C /usr/bin \
    && mv /usr/bin/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf yq_linux_amd64.tar.gz

COPY --from=builder /bin/machineShop /bin/machineShop
