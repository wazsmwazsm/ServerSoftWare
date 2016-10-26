#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
cd $1
export PATH
./configure --prefix=/usr/local/http2  \
--with-apr=/usr/local/apr \
--with-apr-util=/usr/local/apr-util/ \
--with-pcre=/usr/local/pcre \

--enable-modules=all \
--enable-mods-shared=all \
--enable-so
make 
make install
