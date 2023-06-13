{{/*
Return the current data&time in a specific format
*/}}
{{- define "sthings-helm-toolkit.currentDateTime" -}}
{{ now | date "2006-01-02T15:04:05.000006+0000" }}
{{- end }}

{{/*
Deployment labels
*/}}
{{- define "sthings-helm-toolkit.deploymentLabels" -}}
{{- $envVar := first . -}}
{{- $extraLabels := index . 1 -}}
{{ toYaml $extraLabels }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "sthings-helm-toolkit.podLabels" -}}
{{- $envVar := first . -}}
{{- $extraLabels := index . 1 -}}
{{ toYaml $extraLabels }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sthings-helm-toolkit.labels" -}}
{{- $envVar := first . -}}
{{- $extraLabels := index . 1 -}}
{{- include "sthings-helm-toolkit.selectorLabels" (list $envVar $extraLabels) }}
helm.sh/chart: {{ include "sthings-helm-toolkit.chart" $envVar }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sthings-helm-toolkit.selectorLabels" -}}
{{- $envVar := first . -}}
{{- $extraLabels := index . 1 -}}
{{ toYaml $extraLabels }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sthings-helm-toolkit.fullname" -}}
{{- $envVar := first . -}}
{{- if $envVar.Values.fullnameOverride }}
{{- $envVar.Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default $envVar.Chart.Name $envVar.Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "sthings-helm-toolkit.dockerConfigJson" }}
{{- $registryUrl := index . 0 }}{{- $registryUser := index . 1 }}{{- $registryPassword := index . 2 }}
{{- printf "{\"auths\": {\"%s\": {\"username\": \"%s\", \"password\": \"%s\", \"auth\": \"%s\"}}}" $registryUrl $registryUser $registryPassword (printf "%s:%s" $registryUser $registryPassword | b64enc) | b64enc }}{{- end }}