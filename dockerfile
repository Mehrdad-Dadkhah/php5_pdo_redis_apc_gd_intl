FROM php:5-fpm
MAINTAINER "Mehrdad Dadkhah" <mehrdad@dadkahh.mehrdad>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libpq-dev \
        g++ \
        libicu-dev \
        libxml2-dev \
        libpcre3-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install soap \
    && apt-get purge --auto-remove -y g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# install php-redis
ENV PHPREDIS_VERSION 2.2.7

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# install GD and mcrypt
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN cd /tmp/ && \
    curl -O https://pecl.php.net/get/apcu-4.0.10.tgz && \
    tar zxvf apcu-4.0.10.tgz && \
    mv apcu-4.0.10 /usr/src/php/ext/apcu \
    && docker-php-ext-install -j$(nproc) apcu

RUN sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf

RUN usermod -u 1000 www-data

CMD ["php-fpm"]