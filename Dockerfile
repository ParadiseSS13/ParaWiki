FROM mediawiki:1.45.3-fpm

WORKDIR /var/www/html

# Change default PHP-FPM listen port from 9000 to 9100 to avoid conflict with authentik
RUN sed -i 's/listen = 9000/listen = 9100/g' /usr/local/etc/php-fpm.d/docker.conf

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Grab the other stuff composer needs
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy our extensions in
COPY ./extensions/ /var/www/html/extensions/
COPY ./skins/ /var/www/html/skins/

# Then deal with a million dependencies that go 5 layers down
WORKDIR /var/www/html/extensions/MW-OAuth2Client/vendors/oauth2-client
RUN composer install --no-dev --optimize-autoloader --no-interaction
WORKDIR /var/www/html

# Copy our stuff in
COPY ./extensions/ /var/www/html/extensions/
COPY ./skins/ /var/www/html/skins/

# Sort ownership - this takes a while
RUN chown -R www-data:www-data /var/www/html/extensions /var/www/html/skins

# Make images and sort ownership again
RUN mkdir -p /var/www/html/images && \
    chown -R www-data:www-data /var/www/html/images

EXPOSE 9100

CMD ["php-fpm"]