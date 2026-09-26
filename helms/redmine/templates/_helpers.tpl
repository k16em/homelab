{{- define "redmine.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "redmine.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{ include "redmine.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "redmine.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "redmine.secretName" -}}
{{- if .Values.secretKeyBase.existingSecret -}}
{{- .Values.secretKeyBase.existingSecret -}}
{{- else if .Values.secretKeyBase.value -}}
{{- include "redmine.fullname" . -}}
{{- else -}}
{{- fail "secretKeyBase.existingSecret か secretKeyBase.value のどちらかを指定する必要がある" -}}
{{- end -}}
{{- end -}}

{{- define "redmine.claimName" -}}
{{- .Values.persistence.existingClaim | default (include "redmine.fullname" .) -}}
{{- end -}}
