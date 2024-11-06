# HELM/HOMERUN-BASE

## REDIS-STACK


## HOMERUN-GENERIC-PITCHER

Test

```bash
ADDRESS=https://cluster-test1.labul.sva.de/generic

curl -k -X POST ${ADDRESS} \
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