{{/*
# includeStatement
{{- $envVar := . -}}
{{- range $cronJobName, $cronJob := .Values.cronJobs -}}
{{ include "sthings-helm-toolkit.cron-job" (list $envVar $cronJobName $cronJob) }}
{{ end -}}
*/}}

{{- define "sthings-helm-toolkit.cron-job" -}}
{{- $envVar := first . -}}
{{- $cronJobName := index . 1 -}}
{{- $cronJob := index . 2 -}}
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ $cronJobName }}
  namespace: {{ $cronJob.namespace | default $envVar.Values.namespace }}
spec:
  schedule: {{ $cronJob.schedule | quote }}
  concurrencyPolicy: {{ $cronJob.concurrencyPolicy }}
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: {{ $cronJob.restartPolicy }}
          serviceAccount: {{ $cronJob.serviceAccount }}
          containers:
            - name: {{ $cronJob.container.name }}
              image: {{ $cronJob.container.image }}
              command:
              {{- range $cronJob.container.command }}
                - {{ . }}
              {{- end }}
              {{- if $cronJob.container.env }}
              env:
              {{- range $cronJob.container.env }}
                - name: {{ .name }}
                  value: {{ .value | quote }}
              {{- end }}{{- end }}
{{- end }}

{{/*
stuttgart-things/patrick.hermann@sva.de/2022
*/}}
