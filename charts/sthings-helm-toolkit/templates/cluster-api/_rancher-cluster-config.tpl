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
  annotations:
    field.cattle.io/description: {{ $rancherClusterConfig }} cluster
    created: helm
  labels:
    cluster: {{ $rancherClusterConfig }}
spec:
  kubernetesVersion: {{ $rancherCluster.kubernetesVersion }}
  localClusterAuthEndpoint:
    caCerts: ''
    enabled: false
    fqdn: ''
  {{- if $rancherCluster.cloudCredentialSecretName }}
  cloudCredentialSecretName: {{ $rancherCluster.cloudCredentialSecretName }}
  {{- end }}
  defaultPodSecurityAdmissionConfigurationTemplateName: ''
  defaultPodSecurityPolicyTemplateName: ''
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
      disableSnapshots: false
      s3:
#        bucket: string
#        cloudCredentialName: string
#        endpoint: string
#        endpointCA: string
#        folder: string
#        region: string
#        skipSSLVerify: boolean
      snapshotRetention: 5
      snapshotScheduleCron: 0 */5 * * *
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
      {{- if $rancherCluster.machinePools }}
    machinePools:
      {{- range $k, $v := $rancherCluster.machinePools }}
      - name: {{ $k | lower}}
        controlPlaneRole: {{ if has "controlPlane" $v.roles }}true{{ else }}false{{ end }}
        etcdRole: {{ if has "etcd" $v.roles }}true{{ else }}false{{ end }}
        workerRole: {{ if has "worker" $v.roles }}true{{ else }}false{{ end }}
        quantity: {{ $v.quantity }}
        unhealthyNodeTimeout: 0m
        drainBeforeDelete: true
        machineOS: linux
        labels: {}
        machineConfigRef:
          kind: {{ $v.kind }}
          name: {{ $v.machineConfigRef }}
        paused: {{ $v.paused | default false }}{{ end }}{{- end }}
    registries:
      configs:
        {}
      mirrors:
        {}
    upgradeStrategy:
      controlPlaneConcurrency: {{ $rancherCluster.upgradeStrategy.controlPlaneConcurrency }}
      controlPlaneDrainOptions:
        timeout: {{ $rancherCluster.upgradeStrategy.controlPlaneDrainOptionsTimeout }}
        deleteEmptyDirData: true
        disableEviction: false
        enabled: false
        force: false
        gracePeriod: -1
        ignoreDaemonSets: true
        skipWaitForDeleteTimeoutSeconds: 0
      workerConcurrency: {{ $rancherCluster.upgradeStrategy.workerConcurrency }}
      workerDrainOptions:
        timeout: {{ $rancherCluster.upgradeStrategy.workerDrainOptionsTimeout }}
        deleteEmptyDirData: true
        disableEviction: false
        enabled: false
        force: false
        gracePeriod: -1
        ignoreDaemonSets: true
        skipWaitForDeleteTimeoutSeconds: 0
{{- end }}