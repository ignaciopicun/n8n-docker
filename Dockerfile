FROM n8nio/n8n:latest

USER root

# Crear directorio para nodos custom de n8n e instalar LangWatch
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @langwatch/n8n-observability @langwatch/n8n-nodes-langwatch && \
    chown -R node:node /home/node/.n8n

# Copiar script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER node

WORKDIR /home/node

# Exponer puerto de n8n
EXPOSE 5678

# Usar el script de inicio
CMD ["/start.sh"]
