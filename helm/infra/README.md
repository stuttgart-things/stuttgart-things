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
apiVersion: resources.stuttgart-things.com/v1alpha1
kind: AnsibleRun
metadata:
  name: pdns-entry-labul-vsphere-itnovative3
  namespace: default
spec:
  pipelineRunName: pdns-entry-labul-vsphere-itnovative-3
  inventory:
    - "all+[\"localhost\"]"
  playbooks:
    - "ansible/playbooks/pdns-ingress-entry.yaml"
  ansibleVarsFile:
    - pdns_url+-https://pdns-vsphere.labul.sva.de:8443
    - entry_zone+-sthings-vsphere.labul.sva.de.
    - ip_address+-10.31.102.10
    - hostname+-itnovative3
  gitRepoUrl: https://github.com/stuttgart-things/stuttgart-things.git
  gitRevision: main
  providerRef:
    name: kubernetes-incluster
  vaultSecretName: vault
  pipelineNamespace: tektoncd
  workingImage: eu.gcr.io/stuttgart-things/sthings-ansible:9.2.0
  roles:
    - "https://github.com/stuttgart-things/install-configure-powerdns.git"
```