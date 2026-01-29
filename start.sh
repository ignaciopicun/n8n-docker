#!/bin/bash

# Configurar variables de entorno para LangWatch
export NODE_PATH="/home/node/node_modules"

# Iniciar n8n con LangWatch
echo "Starting n8n with LangWatch..."
exec node /usr/local/lib/node_modules/n8n/bin/n8n
