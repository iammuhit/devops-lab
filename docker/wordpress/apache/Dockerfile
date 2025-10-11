FROM ubuntu:jammy
LABEL io.mayarun.maintainer="Nurul Amin Muhit"
LABEL io.mayarun.url="https://muhit.me/"

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Stockholm

RUN set -eux; \
    apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php && \
    apt-get install -y php-mysql php-json php-curl php-xml php-mbstring php-intl php-zip php-bcmath php-cli && \
    apt-get install -y php-imagick ghostscript && \
    rm -rf /var/lib/apt/lists/*

# Configure Apache
ENV APACHE_DOCUMENT_ROOT=${APACHE_DOCUMENT_ROOT:-/var/www/web} \
    APACHE_SERVER_NAME=${APACHE_SERVER_NAME:-localhost}

RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf && \
    echo "ServerName ${APACHE_SERVER_NAME}" >> /etc/apache2/apache2.conf

# Enable Apache site and modules
RUN a2enmod rewrite && a2enmod ssl

CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 80 443
