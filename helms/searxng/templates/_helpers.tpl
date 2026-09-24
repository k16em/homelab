{{- define "searxng.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "searxng.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{ include "searxng.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "searxng.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "searxng.secretName" -}}
{{- if .Values.secretKey.existingSecret -}}
{{- .Values.secretKey.existingSecret -}}
{{- else if .Values.secretKey.value -}}
{{- include "searxng.fullname" . -}}
{{- else -}}
{{- fail "secretKey.existingSecret か secretKey.value のどちらかを指定する必要がある" -}}
{{- end -}}
{{- end -}}
