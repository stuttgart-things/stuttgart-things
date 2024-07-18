# stuttgart-things/helm/registry

# docker-registry

## INIT
```bash
helmfile init # install helmfile plugins
```

## TEMPLATE
```bash
helmfile template --file registry.yaml -e andre-dev #Example ENV
```

## APPLY
```bash
helmfile apply --file registry.yaml -e andre-dev #EXAMPLE ENV
```

## DESTROY
```bash
helmfile destroy registry.yaml -e andre-dev #EXAMPLE ENV
```

# Commands for podman

## PODMAN LOGIN
```bash
podman login --username sthings --password <password> registry.andre-dev.sthings-vsphere.labul.sva.de
```

## PODMAN TAG
```bash
podman tag namespace/imagename:tagversion registry.andre-dev.sthings-vsphere.labul.sva.de/<exampleimagename>
```

## PODMAN PUSH
```bash
podman push registry.andre-dev.sthings-vsphere.labul.sva.de/<exampleimagename>
```

## PODMAN PULL
```bash
podman pull registry.andre-dev.sthings-vsphere.labul.sva.de/<exampleimagename>
```

# registry commands

## CURL TO LIST ALL IMAGES
```bash
curl -u sthings:<password> -X GET https://registry.andre-dev.sthings-vsphere.labul.sva.de/v2/_catalog | jq .repositories[]
```

## CURL TO LIST IMAGE TAGS
```bash
curl -u sthings:<password> -X GET https://registry.andre-dev.sthings-vsphere.labul.sva.de/v2/<exampleimagename>/tags/list
```

## CURL DELETE IMAGE FROM REGISTRY
```bash
registry='registry.andre-dev.sthings-vsphere.labul.sva.de'
repo_name='exampleimagename'
auth='--user sthings:<password>'
curl $auth -v sSL -X DELETE "https://${registry}/v2/${repo_name}/manifests/$(
    curl $auth -sSL -I \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        "https://${registry}/v2/${repo_name}/manifests/$(
            curl $auth -sSL "https://${registry}/v2/${repo_name}/tags/list" | jq -r '.tags[0]'
        )" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
)"
```

## LIST POD NAME
```bash
kubectl -n registry get pods -o=jsonpath='{.items[0].metadata.name}'
```

## DELETE THE REPOSITORY DIR IN REGISTRY-CONTAINER
```bash
repo_name='exampleimagename'
kubectl -n registry exec --stdin --tty $(kubectl -n registry get pods -o=jsonpath='{.items[0].metadata.name}') -- rm -rf /var/lib/registry/docker/registry/v2/repositories/${repo_name}
```

## CHECK FOR DELETION
```bash
repo_name='exampleimagename'
kubectl -n registry exec --stdin --tty $(kubectl -n registry get pods -o=jsonpath='{.items[0].metadata.name}') -- ls /var/lib/registry/docker/registry/v2/repositories/
```
