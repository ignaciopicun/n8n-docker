#!/bin/bash

# Instalar paquetes de LangWatch para OpenTelemetry
echo "Installing LangWatch OpenTelemetry packages..."
cd /home/node/.n8n
npm install @langwatch/opentelemetry-node @opentelemetry/exporter-trace-otlp-proto

# Configurar variables de entorno para OpenTelemetry
export OTEL_EXPORTER_OTLP_ENDPOINT="https://app.langwatch.ai/api/otel"
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer ${LANGWATCH_API_KEY}"
export OTEL_SERVICE_NAME="${N8N_OTEL_SERVICE_NAME:-n8n}"

# Iniciar n8n con el loader de LangWatch
echo "Starting n8n with LangWatch instrumentation..."
exec node --require @langwatch/opentelemetry-node /usr/local/lib/node_modules/n8n/bin/n8n
