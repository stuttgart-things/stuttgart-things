# stageTime


## BASIC-AUTH SECRET (GIT)

```
apiVersion: v1
kind: Secret
metadata:
  name: basic
type: Opaque
stringData:
  .gitconfig: |
    [url "https://<USERNAME>:<TOKEN>@github.com"]
        insteadOf = https://github.com
    [user]
        name = Patrick Hermann
        email = patrick.hermann@sva.de
  .git-credentials: |
    https://<USERNAME>:<TOKEN>@github.com
```

## SSH SECRET (GIT)

```
apiVersion: v1
kind: Secret
metadata:
  name: github-ssh
data:
  id_rsa: LS0tLS1CRUdJ..
type: Opaque
```

## GIT REGISTRY

```
docker --config /tmp login registry.gitlab.com
cat /tmp/config.json | base64 -w 0
```

```
apiVersion: v1
data:
  config.json: <cat /tmp/config.json | base64 -w 0>
kind: Secret
metadata:
  name: scr-labda-vsphere
type: Opaque
```
