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
common:
  cloudCredentialSecretName: {{ default $envVar.Values.secretsNamespace | default "cattle-global-data" }}:{{ $vsphereMachinePool.cloudCredentialSecretName }}
cloneFrom: {{ $vsphereMachinePool.vmTemplatePath }}/{{ $vsphereMachinePool.vmTemplateName }}
{{- if $vsphereMachinePool.cloudConfig }}
cloudConfig: | {{- $vsphereMachinePool.cloudConfig | toYaml | nindent 0 | replace "|" "" }}{{- end }}
cfgparam:
{{- range $vsphereMachinePool.cfgParams }}
  - {{ . }}{{- end }}
datacenter: {{ $vsphereMachinePool.datacenter }}
{{- if $vsphereMachinePool.datastoreCluster }}
datastoreCluster: {{ $vsphereMachinePool.datastoreCluster }}
{{- end }}
{{- if $vsphereMachinePool.datastore }}
datastore: {{ $vsphereMachinePool.datastore }}
{{- end }}
hostsystem: null
folder: {{ $vsphereMachinePool.vmFolder }}
network:
{{- range $vsphereMachinePool.network }}
  - {{ . }}{{- end }}
cpuCount: {{ $vsphereMachinePool.cpuCount | default "6" | quote }}
diskSize: {{ $vsphereMachinePool.diskSize | default "20480" | quote }}
memorySize: {{ $vsphereMachinePool.memorySize | default "8192" | quote }}
creationType: template
sshPort: "22"
sshUser: docker
sshUserGroup: staff
tag: []
vappProperty: []
customAttribute: []
boot2dockerUrl: ""
cloudinit: ""
contentLibrary: ""
vcenter: ""
vcenterPort: "443"
vappTransport: null
vappIpallocationpolicy: null
vappIpprotocol: null
{{- end }}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
