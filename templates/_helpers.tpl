{{/*
Expand the name of the chart.
*/}}
{{- define "MyAppCtx.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Application image tag
We select by default the Chart appVersion or an override in values
*/}}
{{- define "MyAppCtx.imageTag" }}
{{- $name := default .Chart.AppVersion .Values.image.tag }}
{{- printf "%s" $name }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "MyAppCtx.fullname" }}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-"}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "MyAppCtx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "MyAppCtx.labels" -}}
helm.sh/chart: {{ include "MyAppCtx.chart" . }}
{{ include "MyAppCtx.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "MyAppCtx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "MyAppCtx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
