# stuttgart-things/helm/awx

## INIT/UPDATE DEPENDENCIES

```bash
helmfile init # install helmfile plugins
helmfile deps -f awx.yaml # update helm dependencies
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

### GET secret password for awx
```bash
# if not set previously
kubectl -n awx get secret awx-admin-password -o jsonpath='{.data.password}' | base64 -d
```

### INSTALL AWX COLLECTION
```bash
AWX_COLLECTION=https://artifacts.homerun-dev.sthings-vsphere.labul.sva.de/ansible-collections/sthings-awx-24.338.16.tar.gz #example
ansible-galaxy collection install ${AWX_COLLECTION} -f
```

### SET AWX Controller credentials (example)
```bash
export CONTROLLER_HOST=https://$(kubectl get ingress -n awx |awk '{print $3 }' | grep -v HOSTS) # ADD WITHOUT TRAILING SLASH
export CONTROLLER_USERNAME=sthings
export CONTROLLER_PASSWORD=$(kubectl -n awx get secret awx-admin-password -o jsonpath='{.data.password}' | base64 -d)
```

### PROVISION ALL AWX RESSOURCES
```bash
arr=("baseos" "golang" "nerdctl" "docker" "render_upload_template" "get_execute_terraform" "workflow")
for i in ${!arr[@]};
do
  echo $i "${arr[i]}";
  ansible-playbook sthings.awx."${arr[i]}" -vv;
done
```

Author Information
------------------

```bash
Andre Ebert, stuttgart-things 03/2024
Patrick Hermann, stuttgart-things 03/2024
```


# /home/sthings/.ansible/collections/ansible_collections/sthings/awx/playbooks/check_connection.yaml : add slash
# ansible-playbook sthings.awx.baseos -vv --tags init : cannot run twice

# baseos survery: Enter host name : add hint without domain name
# Run manage filesystem role? = ist not a role
# baseos job template : run-baseos-setup

# golang survey : update to 1.22.6
# remove golang url from survey

# docker kind: install not working no permissions

# ansible-playbook sthings.awx.render_upload_template -vv "Failed to update survey: 'variable' 'vmSize' duplicated in survey question 3."} cloud and lab needs to be commented out