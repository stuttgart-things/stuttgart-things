{{- define "sthings-helm-toolkit.rancher-cluster-config" -}}
{{- $envVar := first . -}}
{{- $rancherClusterConfig := index . 1 -}}
{{- $rancherCluster := index . 2 -}}
---
apiVersion: provisioning.cattle.io/v1
kind: Cluster
metadata:
  name: {{ $rancherClusterConfig }}
  namespace: {{ default $envVar.Values.namespace | default "fleet-default" }}
  finalizers:
  {{- range $rancherCluster.finalizers }}
    - {{ . }}{{- end }}
spec:
  kubernetesVersion: {{ $rancherCluster.kubernetesVersion }}
  localClusterAuthEndpoint: {{ $rancherCluster.localClusterAuthEndpoint }}
  {{- if $rancherCluster.cloudCredentialSecretName }}
  cloudCredentialSecretName: {{ $rancherCluster.cloudCredentialSecretName }}
  {{- end }}
  rkeConfig:
    chartValues:
      rke2-{{ $rancherCluster.cniPlugin | default "calico" }}: {}
      {{- if $rancherCluster.vsphereCsi }}
      rancher-vsphere-cpi:
        vCenter:
          datacenters: {{ $rancherCluster.vsphereCsi.datacenters }}
          host: {{ $rancherCluster.vsphereCsi.host }}
          username: {{ $rancherCluster.vsphereCsi.username }}
          password: {{ $rancherCluster.vsphereCsi.password }}
      rancher-vsphere-csi:
        vCenter:
          datacenters: {{ $rancherCluster.vsphereCsi.datacenters }}
          host: {{ $rancherCluster.vsphereCsi.host }}
          username: {{ $rancherCluster.vsphereCsi.username }}
          password: {{ $rancherCluster.vsphereCsi.password }}
     {{- end }}
    etcd:
      snapshotRetention: {{ $rancherCluster.etcd.snapshotRetention }}
      snapshotScheduleCron: {{ $rancherCluster.etcd.snapshotScheduleCron }}
    machineGlobalConfig:
      cni: {{ $rancherCluster.cniPlugin | default "calico" }}
      {{- if $rancherCluster.disable }}
      disable:
      {{- range $rancherCluster.disable }}
        - {{ . }}{{- end }}{{- end }}
      disable-kube-proxy: {{ $rancherCluster.disableKubeProxy }}
      etcd-expose-metrics: {{ $rancherCluster.etcdExposeMetrics }}
      profile: {{ $rancherCluster.profile }}
    machineSelectorConfig:
      - config:
          protect-kernel-defaults: {{ $rancherCluster.protectKernelDefaults }}
          {{- if $rancherCluster.cloudProviderName }}
          cloud-provider-name: {{ $rancherCluster.cloudProviderName }}{{- end }}
      {{- if $rancherCluster.cloudProviderName }}
    machinePools:
      {{- range $k, $v := $rancherCluster.machinePools }}
      - name: {{ $k | lower}}
        displayName: {{ $k | lower}}
        controlPlaneRole: {{ if has "controlPlane" $v.roles }}true{{ else }}false{{ end }}
        etcdRole: {{ if has "etcd" $v.roles }}true{{ else }}false{{ end }}
        workerRole: {{ if has "worker" $v.roles }}true{{ else }}false{{ end }}
        machineConfigRef:
          kind: {{ $v.kind }}
          name: {{ $k | lower }}
        paused: {{ $v.paused | default false }}{{ end }}{{- end }}
    registries: {{ $rancherCluster.registries }}
    upgradeStrategy:
      controlPlaneConcurrency: {{ $rancherCluster.upgradeStrategy.controlPlaneConcurrency }}
      controlPlaneDrainOptions:
        timeout: {{ $rancherCluster.upgradeStrategy.controlPlaneDrainOptionsTimeout }}
      workerConcurrency: {{ $rancherCluster.upgradeStrategy.workerConcurrency }}
      workerDrainOptions:
        timeout: {{ $rancherCluster.upgradeStrategy.workerDrainOptionsTimeout }}
{{- end }}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
