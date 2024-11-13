# Usamos una imagen oficial de Ruby como base
FROM ruby:3.1

# Instalar dependencias necesarias para la aplicación
# En este caso, vamos a necesitar curl para descargar las gemas y build-essential para compilar algunas dependencias
RUN apt-get update -qq && apt-get install -y build-essential curl && rm -rf /var/lib/apt/lists/*

# Crear un directorio de trabajo para nuestra aplicación
WORKDIR /usr/src/app

# Copiar el Gemfile y Gemfile.lock (si los tienes) a la imagen
# Esto permite instalar las gemas antes de copiar todo el código, lo que acelera las reconstrucciones posteriores
COPY Gemfile Gemfile.lock ./

# Instalar las dependencias Ruby usando Bundler
RUN gem install bundler:2.3.26 && bundle install

# Copiar todo el código fuente de la aplicación al contenedor
COPY . .

# Exponer el puerto en el que la aplicación Sinatra se ejecutará (por defecto 4567)
EXPOSE 4567

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["ruby", "app.rb"]
