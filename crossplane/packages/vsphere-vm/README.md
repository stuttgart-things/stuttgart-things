# stuttgart-things/crossplane/vsphere-vm

## CREATE TFVARS

```bash
# CREATE terraform.tfvars
cat <<EOF > terraform.tfvars
vsphere_user = "<USER>"
vsphere_password = "<PASSWORD>"
vm_ssh_user = "<SSH_USER>"
vm_ssh_password = "<SSH_PASSWORD>"
EOF

# CREATE SECRET
kubectl create secret generic vsphere-tfvars --from-file=terraform.tfvars
```

## PROVIDER-CONFIG IN-CLUSTER

```bash
kubectl apply -f - <<EOF
apiVersion: tf.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  configuration: |
    terraform {
      backend "kubernetes" {
        secret_suffix     = "providerconfig-default"
        namespace         = "crossplane-system"
        in_cluster_config = true
      }
    }
EOF
```

## PROVIDER-CONFIG MINIO S3

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: s3
  namespace: crossplane-system
type: Opaque
stringData:
  AWS_ACCESS_KEY_ID: <ACCESS-KEY>
  AWS_SECRET_ACCESS_KEY: <SECRET-ACCESS-KEY>
EOF
```

```bash
kubectl apply -f - <<EOF
apiVersion: tf.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: artifacts-labul-vsphere
  namespace: default
spec:
  configuration: |
    terraform {
      backend "s3" {
        endpoint = "https://artifacts.automation.sthings-vsphere.labul.sva.de"
        key = "terraform2.tfstate"
        region = "main"
        bucket = "terraform"
        skip_credentials_validation = true
        skip_metadata_api_check = true
        skip_region_validation = true
        force_path_style = true
      }
    }
EOF
```

## PROVIDER-CONFIG GCP

```bash
kubectl apply -f - <<EOF
apiVersion: tf.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: gcp-tuesday-test1
  namespace: crossplane-system
spec:
  credentials:
    - filename: gcp-credentials.json
      source: Secret
      secretRef:
        namespace: crossplane-system
        name: gcp-secret
        key: creds
  configuration: |
    terraform {
      backend "gcs" {
        bucket  = "sthings-bucket-f0b3f1ee7"
        prefix  = "terraform/state"
        credentials = "gcp-credentials.json"
      }
    }
EOF
```