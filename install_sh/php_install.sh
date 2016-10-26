#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
cd $1
export PATH
./configure --prefix=/usr/local/php \
--with-apxs2=/usr/local/http2/bin/apxs \
--with-mysql=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-freetype-dir=/usr/local/freetype \
--with-gd \
--with-zlib --with-libxml-dir=/usr/local/libxml2 \
--with-jpeg-dir=/usr/local/jpeg \
--with-png-dir \
--with-curl=/usr/local/curl \
--enable-gd \
--enable-mbstring=all \
--enable-mbregex \
--enable-shared \
--enable-zip \
--enable-ftp \
--enable-sockets

make 
make install

# copy configure file php.ini to installed directory
cp ./php.ini-development /usr/local/php/lib/php.ini

