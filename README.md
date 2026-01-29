# n8n con LangWatch en Render.com

Este repositorio contiene la configuración necesaria para desplegar n8n con integración de LangWatch en Render.com.

## Archivos incluidos

- `Dockerfile`: Extiende la imagen oficial de n8n y configura el script de inicio
- `start.sh`: Script que instala los paquetes de LangWatch y arranca n8n
- `render.yaml`: Configuración de infraestructura como código para Render

## Cómo desplegar en Render.com

### 1. Sube este código a GitHub

```bash
git init
git add .
git commit -m "Initial commit: n8n with LangWatch"
git remote add origin https://github.com/TU-USUARIO/TU-REPO.git
git push -u origin main
```

### 2. Crea un Web Service en Render

1. Ve a [render.com](https://render.com) e inicia sesión
2. Haz clic en **"New +"** → **"Web Service"**
3. Conecta tu repositorio de GitHub
4. Selecciona este repositorio

### 3. Configura el servicio

En la página de configuración:
- **Name**: `mi-instancia-n8n` (o el nombre que prefieras)
- **Environment**: `Docker`
- **Region**: Elige la región más cercana
- **Instance Type**: Elige tu plan (hay tier gratuito disponible)
- **Dockerfile Path**: `Dockerfile` (por defecto)

### 4. Agrega las variables de entorno

En la sección **Environment Variables**, agrega:

| Clave | Valor |
|-------|-------|
| `N8N_OTEL_SERVICE_NAME` | `mi-instancia-n8n` (o el nombre que prefieras) |
| `LANGWATCH_API_KEY` | `sk-lw-...` (tu API key de LangWatch) |

### 5. Despliega

Haz clic en **"Create Web Service"**

Render construirá y desplegará tu contenedor. El primer despliegue toma 5-10 minutos. Una vez listo, obtendrás una URL como `https://mi-instancia-n8n.onrender.com`

## Despliegue con Blueprint (alternativo)

También puedes usar el archivo `render.yaml` para desplegar con Blueprint:

1. Fork este repositorio
2. Ve a Render Dashboard → **Blueprints**
3. Conecta el repositorio
4. Render detectará `render.yaml` y configurará todo automáticamente
5. Solo necesitas agregar los valores de las variables de entorno

## Variables de entorno adicionales (opcionales)

Puedes agregar más variables de entorno de n8n según necesites. Algunas comunes:

| Variable | Descripción |
|----------|-------------|
| `N8N_BASIC_AUTH_ACTIVE` | `true` para activar autenticación básica |
| `N8N_BASIC_AUTH_USER` | Usuario para autenticación básica |
| `N8N_BASIC_AUTH_PASSWORD` | Contraseña para autenticación básica |
| `WEBHOOK_URL` | URL pública para webhooks (ej: `https://tu-dominio.onrender.com`) |
| `N8N_ENCRYPTION_KEY` | Clave para encriptar credenciales (genera una con `openssl rand -hex 32`) |
| `GENERIC_TIMEZONE` | Zona horaria (ej: `America/Mexico_City`) |

## Persistencia de datos

**Nota importante**: En el tier gratuito de Render, los datos no persisten entre reinicios. Para producción, considera:

1. Usar una base de datos PostgreSQL externa (Render ofrece PostgreSQL)
2. Agregar las variables:
   - `DB_TYPE=postgresdb`
   - `DB_POSTGRESDB_HOST=tu-host`
   - `DB_POSTGRESDB_DATABASE=n8n`
   - `DB_POSTGRESDB_USER=tu-usuario`
   - `DB_POSTGRESDB_PASSWORD=tu-contraseña`

## Más información

- [Documentación de n8n](https://docs.n8n.io/)
- [Documentación de LangWatch](https://docs.langwatch.ai/)
- [Documentación de Render](https://render.com/docs)

## Solución de problemas

### El servicio no arranca
- Verifica que `LANGWATCH_API_KEY` esté configurada correctamente
- Revisa los logs en Render Dashboard

### Los webhooks no funcionan
- Asegúrate de configurar `WEBHOOK_URL` con tu URL de Render

### LangWatch no recibe trazas
- Verifica que tu API key sea válida
- Revisa que `N8N_OTEL_SERVICE_NAME` esté configurado
