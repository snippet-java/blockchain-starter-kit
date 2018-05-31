from nginx:latest
MAINTAINER Christian U. <info@cu-tec.de>

ENV DEBIAN_FRONTEND noninteractive

ENV DOCUMENT_ROOT /usr/share/nginx/html

RUN mkdir -p ${DOCUMENT_ROOT}
RUN chmod 777 ${DOCUMENT_ROOT}
#Install nginx php-fpm php-pdo unzip curl
RUN apt-get update 
RUN apt-get -y install unzip curl php-fpm apt-utils php-curl php-gd php-intl php-pear php-imagick php-imap php-mcrypt php-memcache php-pspell php-recode php*-sqlite php-tidy php-xmlrpc php-xsl sendmail

RUN rm -rf ${DOCUMENT_ROOT}/*
RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
RUN tar -xzvf /wordpress.tar.gz --strip-components=1 --directory ${DOCUMENT_ROOT}

RUN curl -o sqlite-plugin.zip https://downloads.wordpress.org/plugin/sqlite-integration.1.7.zip
RUN unzip sqlite-plugin.zip -d ${DOCUMENT_ROOT}/wp-content/plugins/
RUN rm sqlite-plugin.zip
RUN cp ${DOCUMENT_ROOT}/wp-content/plugins/sqlite-integration/db.php ${DOCUMENT_ROOT}/wp-content
RUN cp ${DOCUMENT_ROOT}/wp-config-sample.php ${DOCUMENT_ROOT}/wp-config.php

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 10m/" /etc/nginx/nginx.conf
RUN sed -i -e "s|include /etc/nginx/conf.d/\*.conf|include /etc/nginx/sites-enabled/\*|g" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 10M/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 10M/g" /etc/php/7.0/fpm/php.ini
RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/7.0/fpm/pool.d/www.conf
RUN sed -i -e "s/;listen.mode = 0660/listen.mode = 0666/g" /etc/php/7.0/fpm/pool.d/www.conf
RUN chown -R www-data.www-data ${DOCUMENT_ROOT}

RUN mkdir -p /var/wordpress/database
RUN chmod 777 /var/wordpress/database
RUN echo "define('DB_DIR', '/var/wordpress/database/');" >> ${DOCUMENT_ROOT}/wp-config.php

COPY default /etc/nginx/sites-available/default
RUN mkdir -p /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 443

VOLUME ['/var/wordpress','/usr/share/nginx/html']

CMD service php7.0-fpm start && nginx
