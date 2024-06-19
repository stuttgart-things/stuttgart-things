# AWX

## INIT
```bash
helmfile init # install helmfile plugins
```

## TEMPLATE
```bash
helmfile template --file awx.yaml -e labul-vsphere #Example ENV
```

## APPLY
```bash
helmfile apply --file awx.yaml -e labul-vsphere #EXAMPLE ENV
```

## DESTROY
```bash
helmfile destroy --file awx.yaml -e labul-vsphere #EXAMPLE ENV
kubectl delete pvc postgres-15-awx-postgres-15-0 -n awx #EXAMPLE PVC DELETION
```

## AWX Configuration

# GET secret password for awx
```bash
kubectl -n awx get secret awx-admin-password -o jsonpath='{.data.password}' | base64 -d
```

# EXPORT AWX Controller credentials
```bash
export CONTROLLER_HOST=https://$(kubectl get ingress -n awx |awk '{print $3 }' | grep -v HOSTS)
export CONTROLLER_PASSWORD=$(kubectl -n awx get secret awx-admin-password -o jsonpath='{.data.password}' | base64 -d)
export CONTROLLER_USERNAME=admin
```

# Provision all awx ressources
```bash
cat <<EOF > provisioning.sh
#!/bin/bash 
plays
for var in $var
do

done
```

+ (for loop) für alle awx resourcen (bashscript)

ansible-playbook sthings.awx.golang -vv
ansible-playbook sthings.awx.docker -vv
ansible-playbook sthings.awx.nerdctl -vv
ansible-playbook sthings.awx.baseos -vv
ansible-playbook sthings.awx.schedule_baseos -vv
ansible-playbook sthings.awx.hello_awx -vv -e test_host=example.labul.sva.de