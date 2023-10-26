# stuttgart-things/tekton-base

## DEPLOYMENT

<details><summary>Namespace</summary>

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: tekton-pipelines
  labels:
    app.kubernetes.io/instance: default
    app.kubernetes.io/part-of: tekton-pipelines
    pod-security.kubernetes.io/enforce: restricted
```

</details>


<details><summary>Deployment</summary>

```bash
TKN_BASE_VERSION=0.50.15
helm upgrade --install tekon-pipelines \
https://github.com/stuttgart-things/stuttgart-things/releases/download/tekton-base-v${TKN_BASE_VERSION}/tekton-base-v${TKN_BASE_VERSION}.tgz \
-n tekton-pipelines --create-namespace
```

</details>


## DEV

```
helm dep update
helm template .
helm upgrade --install tekon-pipelines charts/tekton-base -n tekton-pipelines --create-namespace
```

Author Information
------------------

```yaml
Patrick Hermann, stuttgart-things 03/2023
```