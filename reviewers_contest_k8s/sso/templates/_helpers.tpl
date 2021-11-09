{{/*
Expand the name of the chart.
*/}}
{{- define "reviewers-contest-sso.name" -}}
{{- printf "%s-%s" "sso" (default .Chart.Name .Values.nameOverride) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "reviewers-contest-sso.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- printf "%s-%s" "sso" .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := printf "%s-%s" "sso" (default .Chart.Name .Values.nameOverride) }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name "sso" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "reviewers-contest.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "reviewers-contest-sso.labels" -}}
helm.sh/chart: {{ include "reviewers-contest.chart" . }}
{{ include "reviewers-contest-sso.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "reviewers-contest-sso.selectorLabels" -}}
app.kubernetes.io/name: {{ include "reviewers-contest-sso.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
