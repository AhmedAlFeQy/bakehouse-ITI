{{- define "labels" }}
{{- range $pkey,$pval := .Values.metadata.labels }}
    {{ $pkey }}: {{ $pval | quote }}
{{- end }}
{{- end }}