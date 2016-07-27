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
    keepassx thunderbird gimp viewnior poedit\
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

# copy configs
echo 'Copying httpd/selinux configs'
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.d/php.conf /etc/httpd/conf.d/php.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.d/sites.conf /etc/httpd/conf.d/sites.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/httpd/conf.modules.d/10-php.conf /etc/httpd/conf.modules.d/10-php.conf
sudo cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/selinux/config /etc/selinux/config
sudo chmod 600 /etc/selinux/config

echo 'Enable httpd service'
sudo systemctl enable httpd.service

echo 'Done'
echo 'Need to restart!'
