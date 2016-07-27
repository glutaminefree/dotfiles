#!/bin/bash

########################################################
#                                                      #
# Script for creating configs and new dir for new site #
#                                                      #
# Example:                                             #
#   sudo ./create-site.sh site.loc                     #
#                                                      #
########################################################

user=`whoami`

if [ $user != 'root' ]
then
    echo 'Run as root.'
    exit
fi

sitename=$1

if [ -z "$sitename" ]
then
    echo 'Put new site name as parameter.'
    exit
fi

echo 'Editing configs'
conf=`cat /home/glutaminefree/Yandex.Disk/backups/linux/configs/etc/httpd/conf.d/sites.conf`
siteconf="${conf//dev.loc/$sitename}"
echo "$siteconf" >> /etc/httpd/conf.d/sites.conf
echo "" >> /etc/httpd/conf.d/sites.conf
echo "127.0.0.1  $sitename" >> /etc/hosts


echo 'Creating directories'
mkdir /var/www/html/$sitename/cgi-bin/ -p
cp /home/glutaminefree/Yandex.Disk/backups/linux/configs/etc/httpd/cgi-bin/php5 /var/www/html/$sitename/cgi-bin/php5
chown glutaminefree:glutaminefree /var/www/html/$sitename/ -R
chmod 755 /var/www/html/$sitename/ -R


echo 'Restarting httpd'
systemctl restart httpd.service

echo 'Done'
