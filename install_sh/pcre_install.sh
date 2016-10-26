#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
cd $1
export PATH
./configure --prefix=/usr/local/pcre 
make 
make install
