# HELM/HOMERUN-BASE

## DEPLOY

```bash
ENV_NAME=fluxdev-2
helmfile apply -f homerun-base.yaml -e ${ENV_NAME}
```


kubectl -n homerun port-forward services/homerun-redis-stack-headless 5000:6379
redis-cli -h localhost -p 5000 -a Atlan7is2024



## TEST HOMERUN-GENERIC-PITCHER

Test

```bash
ADDRESS=https://homerun.fluxdev-2.sthings-vsphere.labul.sva.de/generic #https://cluster-test1.labul.sva.de/generic

curl -k -X POST "${ADDRESS}" \
     -H "Content-Type: application/json" \
     -H "X-Auth-Token: IhrGeheimerToken" \
     -d '{
           "title": "Memory System Alert",
           "message": "Memory usage is high",
           "severity": "warning",
           "author": "monitoring-system",
           "timestamp": "2024-5-01T12:00:00Z",
           "system": "flux",
           "tags": "cpu,usage,alert",
           "assigneeaddress": "admin@example.com",
           "assigneename": "Admin",
           "artifacts": "Admin",
           "url": "Admin"
         }'
```