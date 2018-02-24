[<-- Back to main section](../README.md)

# Customizing

## Custom packages (`app` controller)

You can add custom commands in `Dockerfile.*`

## Custom php.ini directives

Modify the `etc/php/development.ini` or `etc/php/production.ini`, it will be added on top of the default php.ini so
you can overwrite any directives.

After modification rebuild your `app` container:

```bash
docker-compose stop
docker-compose build app
docker-compose up -d
```

> You can even use the `make rebuild` [task](/Makefile) in the project root, which does the same job in a more better way.

## Install more/other/custom PHP extensions 

There are situations, where you don't want to build your own PHP docker-images in top of a webdevops docker image and push
it to any registry. For example when you're using it for local development only.

It is possible to make changes in your project specific app container. By adding your appropriate RUN statement(s) in the
[Dockerfile.development](/Dockerfile.development) file and a rebuild this could be done without problems.

**Note:** Not every available PHP extension could be easily installed. It's often easier to perform the steps for installing a PHP
extension manually in a test environment first and then to bring these in the necessary format for running them in a
Docker RUN statement.

### HowTo

"PHP webdevops docker images" are based on official `php` docker images, normally. These provides several helper scripts
within the docker container to more easily install PHP extensions:

> [Please consolidate the official manual about how to install PHP extensions in a PHP docker image](https://github.com/docker-library/docs/tree/master/php#how-to-install-more-php-extensions)!

#### Example: Install PHP extension `intl` in `webdevops/php-apache:7.2` docker image

##### Add necessary commands to your [Dockerfile.development](/Dockerfile.development):

```
RUN apt-get -y update \
    && apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl
```

###### At the end, your [Dockerfile.development](/Dockerfile.development) in your project will look like:

```
FROM webdevops/php-apache:7.2

ENV PROVISION_CONTEXT "development"

# Deploy scripts/configurations
COPY etc/ /opt/docker/etc/

RUN ln -sf /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate \
    && chmod 0644 /opt/docker/etc/cron/crontab \
    && echo >> /opt/docker/etc/cron/crontab \
    && ln -sf /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini


####### INSTALL PHP EXTENSION "INTL" BEGIN #######

RUN apt-get -y update \
    && apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl
    
####### INSTALL PHP EXTENSION "INTL" END #########


# Configure volume/workdir
WORKDIR /app/
```

**As every RUN statement creates a new Docker image layer, it would be better to extend the already existing RUN statement
although that worsens the legibility:**

```
FROM webdevops/php-apache:7.2

ENV PROVISION_CONTEXT "development"

# Deploy scripts/configurations
COPY etc/ /opt/docker/etc/

RUN ln -sf /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate \
    && chmod 0644 /opt/docker/etc/cron/crontab \
    && echo >> /opt/docker/etc/cron/crontab \
    && ln -sf /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini \
    && apt-get -y update \
    && apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl


# Configure volume/workdir
WORKDIR /app/
```

#### Example: Install PHP extension `mssql` in `webdevops/php-apache:7.2` docker image

##### Add necessary commands to your [Dockerfile.development](/Dockerfile.development):

```
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/15.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get -y update \
    && ACCEPT_EULA=Y apt-get --assume-yes install \
    msodbcsql \
    unixodbc \
    unixodbc-dev \
    && printf "\n" | pecl install pdo_sqlsrv \
    && printf "\n" | pecl install sqlsrv \
    && touch /usr/local/etc/php/conf.d/20-mssql.ini \
    && echo -e "extension=sqlsrv.so\nextension=pdo_sqlsrv.so\n" >> /usr/local/etc/php/conf.d/20-mssql.ini
```

###### At the end, your [Dockerfile.development](/Dockerfile.development) in your project will look like:

```
FROM webdevops/php-apache:7.2

ENV PROVISION_CONTEXT "development"

# Deploy scripts/configurations
COPY etc/ /opt/docker/etc/

RUN ln -sf /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate \
    && chmod 0644 /opt/docker/etc/cron/crontab \
    && echo >> /opt/docker/etc/cron/crontab \
    && ln -sf /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini


####### INSTALL PHP EXTENSION "MSSQL" BEGIN #######

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/15.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get -y update \
    && ACCEPT_EULA=Y apt-get --assume-yes install \
    msodbcsql \
    unixodbc \
    unixodbc-dev \
    && printf "\n" | pecl install pdo_sqlsrv \
    && printf "\n" | pecl install sqlsrv \
    && touch /usr/local/etc/php/conf.d/20-mssql.ini \
    && echo -e "extension=sqlsrv.so\nextension=pdo_sqlsrv.so\n" >> /usr/local/etc/php/conf.d/20-mssql.ini
    
####### INSTALL PHP EXTENSION "MSSQL" END #########


# Configure volume/workdir
WORKDIR /app/
```

**As every RUN statement creates a new Docker image layer, it would be better to extend the already existing RUN statement
although that worsens the legibility.**
