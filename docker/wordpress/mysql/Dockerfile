FROM eurolinux/centos-stream-9:latest
LABEL maintainer="Nurul Amin Muhit"
LABEL url="https://muhit.me/"

# Install mariadb-server
RUN set -eux; \
    yum update -y; \
    yum install -y mariadb-server; \
    yum clean all;

VOLUME /var/lib/mysql

# Add database configuration and provision script
COPY config/docker.cnf /etc/my.cnf.d/docker.cnf
COPY --chmod=+x provision.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3306
