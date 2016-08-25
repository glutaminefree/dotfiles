#!/bin/bash

#########################################################################
#                                                                       #
# Script for installing soft/copy configs                               #
# on fresh Fedora                                                       #
#                                                                       #
# Required:                                                             #
#                                                                       #
# * Yandex.Disk full sync                                               #
#   http://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm     #
#                                                                       #
# * configs cloned from github                                          #
#                                                                       #
# * RPM Fusion repo configured                                          #
#   http://rpmfusion.org/Configuration                                  #
#########################################################################

# soft
echo 'Updating soft'
sudo dnf update -y

echo 'Installing soft for work'
sudo dnf install -y\
    zsh git git-cola htop wget httpd php\
    vim vim-X11 ctags-etags\
    ranger highlight atool lynx mediainfo\
    filezilla poedit gimp\
    keepassx thunderbird viewnior\
    dropbox vlc qbittorrent

# default web site
echo 'Creating default web site'
sudo mkdir /var/www/html/dev.loc/ -p
sudo chown glutaminefree:glutaminefree /var/www/html/dev.loc/ -R
mkdir /var/www/html/dev.loc/cgi-bin
cp ~/Yandex.Disk/backups/linux/configs/httpd/cgi-bin/php5 /var/www/html/dev.loc/cgi-bin/php5
chmod 755 /var/www/html/dev.loc/ -R
touch /var/www/html/dev.loc/index.php
chmod 644 /var/www/html/dev.loc/index.php
echo '<?php phpinfo();' >> /var/www/html/dev.loc/index.php

# install composer
cd ~
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo cp /home/glutaminefree/composer.phar /url/local/bin/composer
sudo chmod 755 /url/local/bin/composer

# copy configs
echo 'Copying httpd/selinux configs'
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.d/php.conf            /etc/httpd/conf.d/php.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.d/sites.conf          /etc/httpd/conf.d/sites.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.modules.d/10-php.conf /etc/httpd/conf.modules.d/10-php.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/selinux/config                   /etc/selinux/config
sudo chmod 600 /etc/selinux/config

# copy scripts
sudo cp /home/glutaminefree/documents/scripts/create-site.sh  /usr/local/bin/create-site
sudo cp /home/glutaminefree/documents/scripts/docker-clean.sh /usr/local/bin/docker-clean
sudo chmod 755 /usr/local/bin/create-site
sudo chmod 755 /usr/local/bin/docker-clean

echo 'Enable httpd service'
sudo systemctl enable httpd.service

echo 'Done'
echo 'Need to restart!'
