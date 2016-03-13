# php5_pdo_redis_apc_gd_intl
Docker php5 with critical extensions (redis, gd, apcu, intl, soap, pdo and ... )


Use this image to run a container with latest stable of php5. it ships with:

 - last stable version of Redis extension (official version)
 - Intl extension (official version)
 - Apcu extension ([official build for php7](https://pecl.php.net/package/APCu))
 - Soap
 - PDO (MySQL, PostgreSQL, Sqlite)
 - GD
 - iconv
 - mbstring


----------
##usage

    docker pull mehrdadkhah/php5_pdo_redis_apc_gd_intl