#!/bin/bash

###########################################################
#                                                         #
# Script for installing soft/copy configs on fresh Fedora #
#                                                         #
###########################################################

HOMEPATH='/home/glutaminefree'

cd ~

echo 'Installing soft'
sudo dnf install -y \
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y
sudo dnf install -y \
    make gcc gcc-c++\
    zsh git git-cola htop wget curl \
    vim vim-X11 powerline-fonts \
    ranger highlight atool lynx mediainfo \
    gimp calc keepassx \
    vlc qbittorrent \

echo 'Installing NodeJS'
sudo dnf module install nodejs:16/common

echo 'Installing Oh My Zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'Installing NeoBundle for Vim'
sh -c "$(wget https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh -O -)"

echo 'Cloning dotfiles'
cd ~
git clone git@github.com:glutaminefree/dotfiles.git
cd dotfiles
cp -r * ..
cd ..
rm -rf dotfiles

echo 'Copying scripts'
sudo cp $HOMEPATH/documents/scripts/open_with_vim.sh /usr/local/bin/owv
sudo cp $HOMEPATH/documents/scripts/start-gvim.sh    /usr/local/bin/gvimx
sudo chmod 755 /usr/local/bin/owv
sudo chmod 755 /usr/local/bin/gvimx

echo 'Done'
