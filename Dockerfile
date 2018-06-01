FROM compsy/autovar

# Solves: Missing privilege separation directory: /var/run/sshd
#sed -e 's/<VirtualHost \*:80>/<VirtualHost \*:80>\n\tRewriteEngine On\n\tRewriteRule "\(\.\*\)\/json\$" "\$1\/json\?auto_unbox=TRUE"/g' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/000-default.conf_tmp  && \
run sed -e 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf > /etc/apache2/ports.conf_tmp && \
    mv /etc/apache2/ports.conf_tmp /etc/apache2/ports.conf

RUN sed -e 's/<VirtualHost \*:80>/<VirtualHost \*:8080>\n\tRedirectPermanent "\/init" "http:\/\/localhost:8080\/ocpu\/library\/autovar\/R\/generate_networks?auto_unbox=TRUE"\n\tRedirectPermanent "\/run" "http:\/\/localhost:8080\/ocpu\/library\/autovar\/R\/generate_networks\?auto_unbox=TRUE"/g' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/000-default.conf_tmp && \
    mv /etc/apache2/sites-available/000-default.conf_tmp /etc/apache2/sites-available/000-default.conf && \
    a2enmod alias && \
    service apache2 restart

RUN echo sed -e 's/<VirtualHost \*:80>/<VirtualHost \*:80>\n\tRewriteEngine On\n\tRewriteRule "^init.*" "/ocpu/library/autovar/R/generate_networks?auto_unbox=TRUE"\n\tRewriteRule "^run.*" "/ocpu/library/autovar/R/generate_networks?auto_unbox=TRUE"/g' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/000-default.conf_tmp > /tmp/test
EXPOSE 8080


