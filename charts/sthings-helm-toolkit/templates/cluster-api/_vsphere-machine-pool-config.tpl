{{- define "sthings-helm-toolkit.vsphere-machine-pool-config" -}}
{{- $envVar := first . -}}
{{- $vsphereMachinePoolConfig := index . 1 -}}
{{- $vsphereMachinePool := index . 2 -}}
---
apiVersion: rke-machine-config.cattle.io/v1
kind: VmwarevsphereConfig
metadata:
  name: {{ $vsphereMachinePoolConfig }}
  namespace: {{ default $envVar.Values.namespace | default "fleet-default" }}
cpuCount: {{ $vsphereMachinePool.cpuCount | default "6" | quote }}
diskSize: {{ $vsphereMachinePool.diskSize | default "40000" | quote }}
memorySize: {{ $vsphereMachinePool.memorySize | default "8192" | quote }}
datacenter: {{ $vsphereMachinePool.datacenter }}
{{- if $vsphereMachinePool.datastoreCluster }}
datastoreCluster: {{ $vsphereMachinePool.datastoreCluster }}
{{- end }}
{{- if $vsphereMachinePool.datastore }}
datastore: {{ $vsphereMachinePool.datastore }}
{{- end }}
boot2dockerUrl: null
cfgparam:
{{- range $vsphereMachinePool.cfgParams }}
  - {{ . }}{{- end }}
cloneFrom: {{ $vsphereMachinePool.vmTemplatePath }}/{{ $vsphereMachinePool.vmTemplateName }}
cloudinit: null
common:
  labels: null
  taints: []
contentLibrary: null
creationType: template
customAttribute: []
datastoreCluster: null
folder: {{ $vsphereMachinePool.folder }}
gracefulShutdownTimeout: "0"
hostsystem: null
network:
{{- range $vsphereMachinePool.network }}
  - {{ . }}{{- end }}
os: linux
password: null
pool: {{ $vsphereMachinePool.pool }}
sshPassword: tcuser
sshPort: "22"
sshUser: docker
sshUserGroup: staff
tag: []
{{- if $vsphereMachinePool.cloudConfig }}
cloudConfig: {{- $vsphereMachinePool.cloudConfig | toYaml | nindent 2 }}{{- end }}
username: null
vappIpallocationpolicy: null
vappIpprotocol: null
vappProperty: []
vappTransport: null
vcenter: null
vcenterPort: "443"
{{- end }}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
# exampleValues:
examples:
  - name: vsphere-machine-pool
    values: |
      vsphereMachinePools:
        master-aio:
          vmTemplatePath: /LabUL/vm/stuttgart-things/vm-templates
          vmTemplateName: sthings-u24-k8s
          datacenter: /LabUL
          cpuCount: 6
          memorySize: 8192
          diskSize: 40000
          datastore: /LabUL/datastore/ESX05-Local
          pool: /LabUL/host/Cluster-V6.7/Resources
          cfgParams:
            - disk.enableUUID=TRUE
          network:
            - /LabUL/network/LAB-10.31.103
          folder: /LabUL/vm/stuttgart-things/rancher-things
          cloudConfig: |
            #cloud-config
            package_update: true
            package_upgrade: true
            packages:
              - git
              - curl
              - wget
              - git
            resize_rootfs: true
            growpart:
              mode: auto
              devices: ['/']
              ignore_growroot_disabled: false
            ansible:
              package_name: ansible-core
              install_method: distro
              pull:
                url: "https://github.com/stuttgart-things/stuttgart-things.git"
                playbook_name: ansible/playbooks/base-os-cloudinit.yaml
              run_ansible:
                timeout: 5
              galaxy:
                actions:
                  - ["ansible-galaxy", "collection", "install", "community.crypto"]
                  - ["ansible-galaxy", "collection", "install", "community.general"]
                  - ["ansible-galaxy", "collection", "install", "ansible.posix"]
                  - ["ansible-galaxy", "install", "git+https://github.com/stuttgart-things/manage-filesystem.git"]
                  - ["ansible-galaxy", "install", "git+https://github.com/stuttgart-things/install-configure-vault.git"]
                  - ["ansible-galaxy", "install", "git+https://github.com/stuttgart-things/install-requirements.git"]
                  - ["ansible-galaxy", "install", "git+https://github.com/stuttgart-things/download-install-binary.git"]
                  - ["ansible-galaxy", "install", " git+https://github.com/stuttgart-things/create-os-user.git"]
                  - ["ansible-galaxy", "install", " git+https://github.com/stuttgart-things/create-send-webhook.git"]
            runcmd:
              - wget -O /usr/local/share/ca-certificates/labda-vsphere-ca.crt https://vault-vsphere.tiab.labda.sva.de:8200/v1/pki/ca/pem --no-check-certificate
              - wget -O /usr/local/share/ca-certificates/labul-vsphere-ca.crt https://vault-vsphere.labul.sva.de:8200/v1/pki/ca/pem --no-check-certificate
              - wget -O /usr/local/share/ca-certificates/labul-ca.crt https://vault.labul.sva.de:8200/v1/pki/ca/pem --no-check-certificate
              - wget -O /usr/local/share/ca-certificates/labda-ca.crt https://vault.tiab.labda.sva.de:8200/v1/pki/ca/pem --no-check-certificate
              - update-ca-certificates
*/}}
