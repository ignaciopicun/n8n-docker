#!/bin/bash

# Configurar EXTERNAL_HOOK_FILES para LangWatch
export EXTERNAL_HOOK_FILES=$(node -e "console.log(require.resolve('@langwatch/n8n-observability'))")
export N8N_OTEL_SERVICE_NAME="${N8N_OTEL_SERVICE_NAME:-n8n}"

# Iniciar n8n con LangWatch
echo "Starting n8n with LangWatch observability..."
exec n8n
