   # Usa una imagen base adecuada
   FROM node:18

   # Establece el directorio de trabajo
   WORKDIR /app

   # Copia los archivos de tu proyecto
   COPY package.json yarn.lock ./

   # Instala las dependencias
   RUN yarn install --frozen-lockfile

   # Copia el resto de los archivos
   COPY . .

   # Comando para construir tu aplicación
   RUN yarn run build

   # Comando para iniciar tu aplicación
   CMD ["yarn", "start"]