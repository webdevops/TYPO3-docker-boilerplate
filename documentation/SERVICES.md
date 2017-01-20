[<-- Back to main section](../README.md)

# Services

### App (PHP with Nginx or Apache HTTPd)

Setting       | Value
------------- | -------------
Host          | app:80 and app:443 (ssl)
External Port | 8000 and 8443 (ssl)

### MySQL

You can choose between [MySQL](https://www.mysql.com/) (default), [MariaDB](https://www.mariadb.org/)
and [PerconaDB](http://www.percona.com/software) in `docker/mysql/Dockerfile`

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Database      | typo3 (if not changed in env)
Host          | mysql:3306
External Port | 13306

Access fo MySQL user "root" and "dev" will be allowed from external hosts (eg. for debugging, dumps and other stuff).


### PostgreSQL (disabled by default)

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Host          | postgres:5432
External Port | 15432


### Solr (disabled by default)

Setting       | Value
------------- | -------------
Host          | solr:8983
External Port | 18983
Cores         | docker/solr/conf/solr.xml (data dirs are created automatically)

[More details about out-of-the-box supported TYPO3 solr versions](../docker/solr/TYPO3-SOLR-VERSION-MATRIX.md)

### Elasticsearch (disabled by default)

Setting       | Value
------------- | -------------
Host          | elasticsearch:9200 and :9300
External Port | 19200 and 19300

### Redis (disabled by default)

Setting       | Value
------------- | -------------
Host          | redis
Port          | 6379

### Memcached (disabled by default)

Setting       | Value
------------- | -------------
Host          | memcached
Port          | 11211

### Mail Sandbox Tools

#### Mailhog

Setting       | Value
------------- | -------------
Host          | mail
SMTP port     | 1025
Web port      | 8025

#### Mailcatcher (disabled by default)

Setting       | Value
------------- | -------------
Host          | mail
SMTP port     | 1025
Web port      | 1080

#### Mailsandbox (disabled by default)

Setting       | Value
------------- | -------------
Host          | mail
SMTP port     | 1025
Web port      | 80

### FTP (disabled by default)

Setting       | Value
------------- | -------------
Host          | ftp
Ports         | 20,21
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Path          | /storage/ftp (if not changed in env)

### PhpMyAdmin (disabled by default)

Setting       | Value
------------- | -------------
Host          | phpmyadmin
Ports         | 8001
Log in server | mysql
Username      | dev (if not changed in env, see mysql container configuration)
Password      | dev (if not changed in env, see mysql container configuration)
