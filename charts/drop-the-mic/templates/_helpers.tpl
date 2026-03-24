{{/*
Expand the name of the chart.
*/}}
{{- define "drop-the-mic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "drop-the-mic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "drop-the-mic.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "drop-the-mic.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "drop-the-mic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "drop-the-mic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Operator image
*/}}
{{- define "drop-the-mic.operatorImage" -}}
{{ .Values.operator.image.repository }}:{{ .Values.operator.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
UI server image
*/}}
{{- define "drop-the-mic.serverImage" -}}
{{ .Values.ui.image.repository }}:{{ .Values.ui.image.tag | default .Chart.AppVersion }}
{{- end }}
