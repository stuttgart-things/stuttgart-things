# stuttgart-things/yacht

## APPLY TO ENV
```
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