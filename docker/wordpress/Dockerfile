FROM ubuntu:jammy
LABEL io.mayarun.maintainer="Nurul Amin Muhit"
LABEL io.mayarun.url="https://muhit.me/"

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Stockholm

RUN set -eux; \
    apt-get update && \
    apt-get install -y mysql-server apache2 php libapache2-mod-php && \
    apt-get install -y php-mysql php-json php-curl php-xml php-mbstring php-intl php-zip php-bcmath php-cli && \
    apt-get install -y php-imagick ghostscript && \
    apt-get install -y wget unzip vim supervisor && \
    rm -rf /var/lib/apt/lists/*

# Create Wordpress database and user
RUN service mysql start && \
    mysql -u root -e 'CREATE DATABASE wordpress;' && \
    mysql -u root -e 'CREATE USER wordpress@localhost IDENTIFIED WITH mysql_native_password BY "Administrator";' && \
    mysql -u root -e 'GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost;' && \
    mysql -u root -e 'FLUSH PRIVILEGES;' && \
    service mysql stop

# Download and extract Wordpress
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /var/www/ && \
    rm /tmp/wordpress.zip

# Set app directory permissions
RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

WORKDIR /var/www/wordpress

# Configure Wordpress database settings
RUN cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php && \
    chown www-data:www-data /var/www/wordpress/wp-config.php && \
    chmod 0644 /var/www/wordpress/wp-config.php

RUN sed -i 's/database_name_here/wordpress/' /var/www/wordpress/wp-config.php && \
    sed -i 's/username_here/wordpress/' /var/www/wordpress/wp-config.php && \
    sed -i 's/password_here/Administrator/' /var/www/wordpress/wp-config.php && \
    sed -i 's/localhost/127.0.0.1/' /var/www/wordpress/wp-config.php

# Configure Apache
ENV APACHE_DOCUMENT_ROOT=/var/www/web
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY --chown=www-data apache/config/wordpress.conf /etc/apache2/sites-available/wordpress.conf
COPY --chown=www-data apache/config/wordpress-ssl.conf /etc/apache2/sites-available/wordpress-ssl.conf

# Enable Apache site and modules
RUN a2enmod rewrite && a2enmod ssl && \
    a2dissite 000-default && a2ensite wordpress && \
    a2dissite default-ssl && a2ensite wordpress-ssl && \
    service apache2 restart

# Create supervisord config to run MySQL + Apache
COPY supervisor/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
EXPOSE 80 443
