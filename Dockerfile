FROM mediawiki:1.45.3-fpm

WORKDIR /var/www/html

# Change default PHP-FPM listen port from 9000 to 9100 to avoid conflict with authentik
RUN sed -i 's/listen = 9000/listen = 9100/g' /usr/local/etc/php-fpm.d/docker.conf

COPY ./extensions/ /var/www/html/extensions/
COPY ./skins/ /var/www/html/skins/

RUN chown -R www-data:www-data /var/www/html/extensions /var/www/html/skins

RUN mkdir -p /var/www/html/images && \
    chown -R www-data:www-data /var/www/html/images

EXPOSE 9100

CMD ["php-fpm"]