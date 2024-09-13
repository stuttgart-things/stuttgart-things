# stuttgart-things/crossplane/packages

## INSTALL CROSSPLANE CLI

```bash
curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" |sh
```

## INIT PACKAGE

```bash
PACKAGE_NAME=registry
crossplane xpkg init ${PACKAGE_NAME} configuration-template
```

## BUILD PACKAGE

```bash
crossplane xpkg build
```

## LOGIN INTO REGISTRY (EXAMPLE)

```bash
PACKAGE_NAME=registry
crossplane xpkg init ${PACKAGE_NAME} configuration-template
```

## PUSH TO REGISTRY

```bash
REGISTRY=ghcr.io/stuttgart-things/stuttgart-things
PACKAGE_NAME=xplane-registry
TAG=2.2.3

crossplane xpkg push ${REGISTRY}/${PACKAGE_NAME}:${TAG}
rm -rf *.xpkg
```

## INSTALL CONFIGURATION PACKAGE ON CLUSTER

```bash
kubectl apply -f - <<EOF
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: xplane-registry
spec:
  package: ghcr.io/stuttgart-things/stuttgart-things/xplane-registry:2.2.3
EOF
```