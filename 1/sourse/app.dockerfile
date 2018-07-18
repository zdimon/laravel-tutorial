FROM php:7.1-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    libpq-dev \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pgsql pdo pdo_pgsql
    
RUN chown -R www-data:www-data /var/www
