# INFRA DEPLOYMENT

## LONGHORN

```bash
helmfile apply --file longhorn.yaml -e labul-vsphere
```

## NETWORK STACK

check env values!

* metallb
* ingress-nginx
* cert-manager

```bash
helmfile apply --file network-mnc-stack.yaml -e labul-vsphere
```

## DNS

works only for stuttgart-things project

```yaml
LAB=labul
CLOUD=pve
CLUSTER_NAME=rancher-mgmt
ZONE=sthings-pve.labul.sva.de.
IP=10.31.101.5
PR=$(echo $((1 + SRANDOM % 1000)))

kubectl apply -f - <<EOF
apiVersion: resources.stuttgart-things.com/v1alpha1
kind: AnsibleRun
metadata:
  name: pdns-${LAB}-${CLOUD}-${CLUSTER_NAME}
  namespace: default
spec:
  pipelineRunName: pdns-${LAB}-${CLOUD}-${CLUSTER_NAME}-${PR}
  inventory:
    - "all+[\"localhost\"]"
  playbooks:
    - "ansible/playbooks/pdns-ingress-entry.yaml"
  ansibleVarsFile:
    - pdns_url+-https://pdns-${CLOUD}.${LAB}.sva.de:8443
    - entry_zone+-${ZONE}
    - ip_address+-${IP}
    - hostname+-${CLUSTER_NAME}
  gitRepoUrl: https://github.com/stuttgart-things/stuttgart-things.git
  gitRevision: main
  providerRef:
    name: kubernetes-incluster
  vaultSecretName: vault
  pipelineNamespace: tektoncd
  workingImage: eu.gcr.io/stuttgart-things/sthings-ansible:10.0.1
  roles:
    - "https://github.com/stuttgart-things/install-configure-powerdns.git"
EOF
```