# VsphereRke2Cluster

## DEPLOY

```bash

```


## VERIFY/TRACE

```bash
crossplane beta trace minio fluxdev-2 -n crossplane-system
```

## RENDER

```bash
crossplane render examples/claim.yaml apis/composition.yaml examples/functions.yaml
```