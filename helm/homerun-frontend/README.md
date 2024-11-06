# HELM/HOMERUN-BASE

## HOMERUN-EVENT-CATCHER

TEST SSE (LIVE DATA)

```bash
ENDPOINT=cluster-test1.labul.sva.de

curl -k https://${ENDPOINT}/events
```

TEST DOCUMENT (API-ENDPOINT)

```bash
ENDPOINT=cluster-test1.labul.sva.de

curl -k https://${ENDPOINT}/documents
curl -k https://${ENDPOINT}/documents?system=gitlab&limit=1
```