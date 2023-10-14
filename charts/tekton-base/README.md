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

## PIPELINE SA

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tektoncd
  namespace: tektoncd
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: tektoncd
  name: tektoncd
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create", "get", "watch", "list"]
- apiGroups: ["batch"]
  resources: ["jobs"]
  verbs: ["create", "get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: tektoncd
  namespace: tektoncd
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: tektoncd
subjects:
- kind: ServiceAccount
  name: tektoncd
  namespace: tektoncd
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: list-all-namespaces-and-jobs-tektoncd
rules:
- apiGroups: [""]
  resources: ["namespaces"]
  verbs: ["get", "list"]
- apiGroups: ["batch"]
  resources: ["jobs"]
  verbs: ["create", "get", "patch", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: list-all-namespaces-and-jobs-tektoncd
subjects:
- kind: ServiceAccount
  name: tektoncd
  namespace: tektoncd
roleRef:
  kind: ClusterRole
  name: list-all-namespaces-and-jobs-tektoncd
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tekton-pipelines-controller-cluster-access-tektoncd
subjects:
- kind: ServiceAccount
  name: tektoncd
  namespace: tektoncd
roleRef:
  kind: ClusterRole
  name: tekton-pipelines-controller-cluster-access
  apiGroup: rbac.authorization.k8s.io
```

Author Information
------------------
```
Patrick Hermann, stuttgart-things 03/2023
```