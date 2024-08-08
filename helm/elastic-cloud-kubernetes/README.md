stuttgart-things/helm/elastic-cloud-kubernetes


```bash
kubectl -n elastic-system get secret elasticsearch-cluster-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
```