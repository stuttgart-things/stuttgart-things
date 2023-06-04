# stuttgart-things/yacht

## ISSUES

* tekton-pipelines-resolvers namespace
* api version pipelines

## APPLY TO ENV
```
export VAULT_NAMESPACE=root
export VAULT_TOKEN=<VAULT_TOKEN>
export VAULT_ADDR=https://vault-vsphere.tiab.labda.sva.de:8200

helmfile apply --environment labda
```

## TEST YAS
```
# example ingress address
yacht-application-client send --endpoint yas.mgmt.4sthings.tiab.ssc.sva.de --file tests/yacht.json
```


## TEMPLATE ENV RELEASE
```
helmfile template --environment labda
```

## VERIFY VALUES
```
helmfile write-values --environment labda
```

## CHECK DIFFS
```
helmfile diffs --environment labda
```

Author Information
------------------
Patrick Hermann, stuttgart-things 03/2023
