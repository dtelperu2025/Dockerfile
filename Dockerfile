FROM php:8.3-apache

# Instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    zip \
    nano \
    default-mysql-client \
    libpng-dev \
    libonig-dev \
    libzip-dev

# Instalar extensiones PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Permitir mod_rewrite (Laravel lo necesita)
RUN a2enmod rewrite

# Permisos Laravel
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD php artisan serve --host=0.0.0.0 --port=8000