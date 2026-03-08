# Use official PHP Apache image
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY index.php /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose apache port
EXPOSE 80