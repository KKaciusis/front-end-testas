ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-fpm-alpine AS php_builder

# https://pecl.php.net/package/APCu
ARG APCU_VERSION=5.1.19
# https://xdebug.org/
ARG XDEBUG_VERSION=3.0.1

# Install missing deps if needed
RUN apk add --no-cache \
       bash git make perl ncurses;

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		libzip-dev \
		mysql-dev \
		zlib-dev \
        libxml2-dev \
        libxslt-dev \
        oniguruma-dev \
        curl-dev \
        postgresql-dev \
	; \
	docker-php-ext-configure intl; \
	docker-php-ext-install -j$(nproc) \
		intl \
		gd \
		pdo \
		pdo_mysql \
        pdo_pgsql \
		zip \
		bcmath \
		sockets \
		zip \
		xml \
		posix \
		fileinfo \
		mbstring \
		curl \
		mysqli \
	; \
    pecl install apcu-${APCU_VERSION}; \
	pecl install xdebug-${XDEBUG_VERSION}; \
    docker-php-ext-enable xdebug; \
	\
	pecl clear-cache; \
	docker-php-ext-enable \
		apcu \
		opcache \
	; \
    runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --no-cache --virtual .api-phpexts-rundeps $runDeps; \
	\
	apk del .build-deps; \
	\
	sed -i '/^access.log/ d' /usr/local/etc/php-fpm.d/docker.conf;

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN ln -s $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

COPY --from=golang:1.15-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini

WORKDIR var/www/site
