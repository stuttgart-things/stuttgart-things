# stuttgart-things/crossplane/vsphere-vm-ansible

## CREATE TFVARS FOR SECRETS

```bash
API_USER=""
API_PW=""
SSH_USER=""
SSH_PW=""
VSPHERE_SERVER=10.31.101.51
SECRET_NAME=vsphere-tfvars
NAMESPACE=crossplane-system
# CREATE terraform.tfvars
VARS_FILE=terraform.tfvars
cat <<EOF > ${VARS_FILE}
vsphere_user = "${API_USER}"
vsphere_password = "${API_PW}"
vm_ssh_user = "${SSH_USER}"
vm_ssh_password = "${SSH_PW}"
vsphere_server="${VSPHERE_SERVER}"
EOF

kubectl create secret generic ${SECRET_NAME} --from-file=${VARS_FILE} -n ${NAMESPACE}
rm -rf ${VARS_FILE}
```

## PROVIDER-CONFIG IN-CLUSTER

```bash
kubectl apply -f - <<EOF
apiVersion: tf.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: u24-ansible
spec:
  configuration: |
    terraform {
      backend "kubernetes" {
        secret_suffix     = "u24-ansible"
        namespace         = "crossplane-system"
        in_cluster_config = true
      }
    }
EOF
```