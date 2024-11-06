# stuttgart-things/helm/headlamp

## DEPLOY

```bash
helmfile apply -f headlamp.yaml  -e k3s
```

## GET TOKEN
```bash
kubectl create token headlamp-admin -n kube-system
```
