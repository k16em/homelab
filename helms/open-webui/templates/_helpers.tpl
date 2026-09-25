{{- define "open-webui.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "open-webui.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{ include "open-webui.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "open-webui.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "open-webui.secretName" -}}
{{- if .Values.secretKey.existingSecret -}}
{{- .Values.secretKey.existingSecret -}}
{{- else if .Values.secretKey.value -}}
{{- include "open-webui.fullname" . -}}
{{- else -}}
{{- fail "secretKey.existingSecret か secretKey.value のどちらかを指定する必要がある" -}}
{{- end -}}
{{- end -}}

{{- define "open-webui.claimName" -}}
{{- .Values.persistence.existingClaim | default (include "open-webui.fullname" .) -}}
{{- end -}}
