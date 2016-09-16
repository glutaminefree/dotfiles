#!/bin/bash

#########################################################################
#                                                                       #
# Script for installing soft/copy configs on fresh Fedora               #
#                                                                       #
#                                                                       #
# Required:                                                             #
#                                                                       #
# * configs cloned from github                                          #
#   https://github.com/glutaminefree/dotfiles                           #
#                                                                       #
#########################################################################

HOMEPATH='/home/glutaminefree'

# soft
echo 'Updating soft'
sudo dnf update -y

echo 'Installing soft for work'
sudo dnf install -y \
    https://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm \
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(lsb_release -r -s ).noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(lsb_release -r -s ).noarch.rpm
sudo dnf update -y
sudo dnf install -y \
    zsh git git-cola htop wget docker \
    vim vim-X11 ctags-etags \
    ranger highlight atool lynx mediainfo \
    filezilla poedit gimp \
    keepassx thunderbird viewnior \
    dropbox vlc qbittorrent \

echo 'Installing Oh My Zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
mkdir $HOMEPATH/.oh-my-zsh/custom/themes/ -p
cp $HOMEPATH/documents/configs/oh-my-zsh/pygmalion.zsh-theme $HOMEPATH/.oh-my-zsh/custom/themes/pygmalion.zsh-theme

echo 'Installing NeoBundle for Vim'
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

# copy scripts
sudo cp $HOMEPATH/documents/scripts/docker-clean.sh  /usr/local/bin/docker-clean
sudo cp $HOMEPATH/documents/scripts/open_with_vim.sh /usr/local/bin/owv
sudo cp $HOMEPATH/documents/scripts/translate.sh /usr/local/bin/trans
sudo chmod 755 /usr/local/bin/docker-clean
sudo chmod 755 /usr/local/bin/owv
sudo chmod 755 /usr/local/bin/trans

echo 'Done'
