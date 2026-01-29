FROM n8nio/n8n:latest

USER root

# Instalar paquetes de LangWatch para OpenTelemetry
WORKDIR /home/node
RUN npm install langwatch

# Copiar script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER node

# Exponer puerto de n8n
EXPOSE 5678

# Usar el script de inicio
CMD ["/start.sh"]
