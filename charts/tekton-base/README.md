# stuttgart-things/tekton-base

## DEPLOYMENT

```
TKN_BASE_VERSION=0.50.15
helm upgrade --install tekon-pipelines \
https://github.com/stuttgart-things/stuttgart-things/releases/download/tekton-base-v${TKN_BASE_VERSION}/tekton-base-v${TKN_BASE_VERSION}.tgz \
-n tekton-pipelines --create-namespace

```

## DEV

```
helm dep update
helm template .
helm upgrade --install tekon-pipelines charts/tekton-base -n tekton-pipelines --create-namespace
```

Author Information
------------------
```
Patrick Hermann, stuttgart-things 03/2023
```
