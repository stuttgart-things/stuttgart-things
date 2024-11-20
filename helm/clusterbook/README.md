# stuttgart-things/helm/clusterbook/

## GET IPS (EXAMPLE)

```bash
machineshop get \
--system=ips \
--destination=clusterbook.homerun-dev.sthings-vsphere.labul.sva.de:443 \
--path=10.31.103 \
--output=2
```

## SET IP TO CLUSTER

```bash
IPS="10.31.103.9;10.31.103.10"
CLUSTER_NAME=fluxdev-2

machineshop push \
--target=ips \
--destination=clusterbook.homerun-dev.sthings-vsphere.labul.sva.de:443 \
--artifacts="${IPS}" \
--assignee=${CLUSTER_NAME}
```
## CONFIG EXAMPLE

```bash
kubectl apply -f - <<EOF
apiVersion: github.stuttgart-things.com/v1
kind: NetworkConfig
metadata:
  name: networks-labul
  namespace: clusterbook
spec:
  networks:
    10.31.101:
    - 5:ASSIGNED:rancher-mgmt
    - "6"
    - "7"
    - 8:ASSIGNED:flux-dev-3
    - 9:ASSIGNED:flux-dev-3
    - "10"
    - "11"
    - "12"
    - "13"
    - "14"
    - "15"
    10.31.102:
    - "5"
    - "6"
    - "7"
    - "8"
    - "9"
    - "10"
    - "11"
    - "12"
    - "13"
    - "14"
    - "15"
    10.31.103:
    - 5:ASSIGNED:labul-automation
    - 6:ASSIGANED:labul-automation
    - "7"
    - "8"
    - "9"
    - "10"
    - "11"
    - "12"
    - "13"
    - "14"
    - 15:ASSIGNED:homerun-dev
    - 16:ASSIGNED:homerun-dev
    - 17:ASSIGNED:homerun-dev
    - 18:ASSIGNED:rke2-28
    - 19:ASSIGNED:labul-automation
    10.31.104:
    - "5"
    - "6"
    - "7"
    - "8"
    - "9"
    - "10"
    - "11"
    - "12"
    - "13"
    - "14"
    - "15"
EOF
```
