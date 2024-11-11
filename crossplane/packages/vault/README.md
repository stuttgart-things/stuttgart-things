# stuttgart-things/crossplane/vault

## INSTALL CONFIGURATION PACKAGE ON CLUSTER


```
kubectl apply -f - <<EOF
apiVersion: helm.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: helm-incluster
spec:
  credentials:
    source: InjectedIdentity
EOF

SA=$(kubectl -n crossplane-system get sa -o name | grep provider-helm | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-helm-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"
```


```
crossplane render examples/claim.yaml apis/pipeline-composition.yaml apis/func
tion.yaml
```
