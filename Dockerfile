# Use the official PHP 8.2 FPM image
FROM php:8.2-fpm

# Set the working directory inside the container
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    zip unzip curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install xml curl pdo pdo_mysql mbstring exif pcntl bcmath gd \
    && rm -rf /var/lib/apt/lists/*  # Clean up apt cache to reduce image size

# Copy the application files into the container
COPY ./app /var/www/html

# Install Composer (PHP dependency manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies with Composer (exclude dev dependencies and optimize autoloader)
RUN composer install --no-dev --optimize-autoloader

# Expose the necessary port for PHP-FPM (default is 9000)
EXPOSE 9000

# Command to run PHP-FPM
CMD ["php-fpm"]
