# Usa una imagen base de Node.js LTS
FROM node:20-alpine

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de configuración de Yarn
COPY package.json yarn.lock* ./

# Instala las dependencias con Yarn
RUN yarn install --frozen-lockfile

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación (si es necesario)
RUN yarn build

# Variable de entorno para el puerto (Railway asigna automáticamente)
ENV PORT=8080

# Expone el puerto que usará la aplicación
EXPOSE $PORT

# Comando para iniciar la aplicación
CMD ["yarn", "start"]