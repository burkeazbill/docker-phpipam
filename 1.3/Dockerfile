FROM debian:wheezy


RUN DEBIAN_FRONTEND=noninteractive apt-get update \
                                && apt-get -y install apache2 libapache2-mod-php5 php5-mysql vim curl php5-gmp php5-ldap php-pear php5-curl php5-mcrypt php5-gd git \
                                && apt-get clean \
                                && mkdir /var/www/html/

# ADD https://github.com/phpipam/phpipam/archive/1.3.tar.gz /tmp
#RUN curl -o /tmp/1.3.tar.gz https://github.com/phpipam/phpipam/archive/1.3.tar.gz \
#    && tar -xzf /tmp/1.3.tar.gz -C /var/www/html --strip-components=1

RUN git clone https://github.com/phpipam/phpipam.git /var/www/html \
    && cd /var/www/html \
    && git checkout 1.3 \
    && git submodule update --init --recursive

COPY 000-default.conf /etc/apache2/sites-available/default
COPY config.php /var/www/html
COPY MIGRATE.sql /var/www/html/db/MIGRATE.sql

VOLUME ["/ssl"]

RUN a2enmod rewrite
RUN sed -i '/ErrorDocument 511/s/^/# /' /var/www/html/api/.htaccess

# apache env vars
ENV APACHE_LOCK_DIR /var/lock
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2/
ENV APACHE_PID_FILE /var/apache.pid

# Defaults
ENV SSL_ENABLED false
ENV PROXY_ENABLED false

EXPOSE 80 443

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
