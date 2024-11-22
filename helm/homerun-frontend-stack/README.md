# HELM/HOMERUN-FRONTEND

## HOMERUN-EVENT-CATCHER

TEST SSE (LIVE DATA)

```bash
ENDPOINT=cluster-test1.labul.sva.de #homerun.fluxdev-2.sthings-vsphere.labul.sva.de

curl -k https://${ENDPOINT}/events
```

TEST DOCUMENT (API-ENDPOINT)

```bash
ENDPOINT=cluster-test1.labul.sva.de

curl -k https://${ENDPOINT}/documents
curl -k https://${ENDPOINT}/documents?system=gitlab&limit=1
```