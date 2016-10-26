#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# add mysql count
useradd mysql
chmod +x /usr/local/mysql
chown -R mysql:mysql /usr/local/mysql

# init
/usr/local/mysql/scripts/mysql_install_db \
--user=mysql \
--basedir=/usr/local/mysql \
--datadir=/usr/local/mysql/data &

# protect someone wanna to init mysql configure
chown -R root /usr/local/mysql
# date permission support to mysql 
chown -R mysql /usr/local/mysql/data

# start mysql server
/usr/local/mysql/bin/mysqld_safe --user=mysql &
