FROM ghcr.io/stuttgart-things/sthings-alpine:1.23@sha256:486b343e3bac3148e8f4608b11cf68da01493335724d6db2d4fb168bd394b9f0

ARG MACHINE_SHOP_VERSION=2.2.9

# MACHINE-SHOP
RUN wget -q https://github.com/stuttgart-things/machineshop/releases/download/${MACHINE_SHOP_VERSION}/machineshop_Linux_x86_64.tar.gz \
    && tar -xvf machineshop_Linux_x86_64.tar.gz -C /usr/bin/ machineshop \
    && rm -rf machineshop_Linux_x86_64.tar.gz