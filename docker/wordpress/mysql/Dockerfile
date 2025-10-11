FROM eurolinux/centos-stream-9:latest
LABEL io.mayarun.maintainer="Nurul Amin Muhit"
LABEL io.mayarun.url="https://muhit.me/"

# Docker Environs
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-} \
    MYSQL_DATABASE=${MYSQL_DATABASE:-} \
    MYSQL_USER=${MYSQL_USER:-} \
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-}

# Install systemd and mariadb-server
RUN set -eux; \
    yum install -y epel-release systemd && \
    yum install -y mariadb-server && \
    yum clean all

# Add database configuration and provision script
COPY config/docker.cnf /etc/my.cnf.d/docker.cnf
COPY mariadb-init.svc /etc/systemd/system/mariadb-init.service
COPY --chmod=+x mariadb-init.sh /usr/local/bin/mariadb-init.sh
COPY --chmod=+x docker-command.sh /usr/local/bin/docker-command.sh

# Enable database service
RUN systemctl enable mariadb-init && \
    systemctl enable mariadb

VOLUME ["/var/lib/mysql"]
CMD ["docker-command.sh"]
EXPOSE 3306
