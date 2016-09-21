#!/bin/bash
wget http://ru.wordpress.org/latest-ru_RU.tar.gz
tar -xzvf latest-ru_RU.tar.gz
cd wordpress
touch .htaccess
mv * .[^.]* ..
cd ..
rm latest-ru_RU.tar.gz
rm -rf wordpress
