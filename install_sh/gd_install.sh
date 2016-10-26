#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
cd $1
export PATH
./configure --prefix=/usr/local/gd  \
--with-jpeg=/usr/local/jpeg/    \
--with-png --with-zlib \
--with-freetype=/usr/local/freetype

make 
make install
