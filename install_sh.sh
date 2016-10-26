#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin
export PATH

passwd='wzdanzsm'

# permission
echo $passwd | sudo -S chown -R mrq:mrq ./
echo $passwd | sudo -S chmod -R 755 ./

echo $passwd | sudo -S apt-get update

libname=("vsftpd" "gcc" "g++" "make" "libncurses5-dev" "libnewt-dev")


# @ Used to traverse the array
for i in ${libname[@]}
do
    read -p "Do you want to install $i ? [Y/N] : " yn
    while [ "$yn" != "Y" ] && [ "$yn" != "y" ] && [ "$yn" != "N" ] && [ "$yn" != "n" ]
    do
        read -p "Please input [Y/N] : " yn
    done

    if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
        echo $passwd | sudo -S apt-get -y install $i  > /dev/null 2>&1
        if [ $? == '0' ]; then
                echo "$i installed"        
            else
                echo "$i install failed"
        fi
    elif [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
        echo "Ignore $i ..."
    else
        echo "I don't understand this!"
        exit
    fi
done

# install tar software
test -d ./.cache || mkdir ./.cache

echo "start unpack"

TAR_FILES=`ls *.tar.*`

for tar_file in $TAR_FILES
do
    echo "unpacking $tar_file"
    if [ ${tar_file##*.} == "gz" ]; then # gz
        echo $passwd | sudo -S tar -zx -f $tar_file -C ./.cache
    else # bz2
        echo $passwd | sudo -S tar -jx -f $tar_file -C ./.cache
    fi

    if [ $? == '0' ]; then
        echo "$i unpacked"        
    else
        echo "$i unpack failed"
    fi
done

echo "start install"

softname=("zlib" "apr" "apr-util" "pcre" "httpd" "libxml" "libpng" "jpeg" "gd" "freetype" "curl" "php" "cmake" "mysql")

for soft in ${softname[@]}
do
    read -p "Do you want to install $soft ? [Y/N] : " yn
    while [ "$yn" != "Y" ] && [ "$yn" != "y" ] && [ "$yn" != "N" ] && [ "$yn" != "n" ]
    do
        read -p "Please input [Y/N] : " yn
    done

    if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
        echo "installing $soft"
        echo $passwd | sudo -S "./install_sh/${soft}_install.sh" ./.cache/$soft*
    elif [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
        echo "Ignore $soft ..."
    else
        echo "I don't understand this!"
        exit
    fi   
done

echo "init mysql"
echo $passwd | sudo -S ./mysql_init.sh

read -p "Do you want to enter mysql set passwd and complete install now? [Y/N] : " yn
while [ "$yn" != "Y" ] && [ "$yn" != "y" ] && [ "$yn" != "N" ] && [ "$yn" != "n" ]
do
    read -p "Please input [Y/N] : " yn
done

if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
    mysql -hlocalhost -uroot 
elif [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
    echo "Install completed , please set mysql password Manual"
else
    echo "I don't understand this!"
    exit
fi

# clean cache
echo $passwd | sudo -S rm -rf ./.cache
