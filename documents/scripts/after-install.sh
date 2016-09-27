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
    https://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm \
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y
sudo dnf install -y \
    rxvt-unicode-256color-ml \
    make gcc \
    #VirtualBox kmod-VirtualBox kernel-devel \
    zsh git git-cola htop wget scrot \
    vim vim-X11 ctags-etags \
    ranger highlight atool lynx mediainfo \
    filezilla poedit gimp \
    keepassx thunderbird viewnior \
    dropbox vlc qbittorrent \

echo 'Generating SSH keys'
ssh-keygen -t rsa -b 4096 -C "glutaminefree@mail.ru"
echo 'Copy this key:'
cat ~/.ssh/id_rsa.pub
echo 'and add it to https://github.com/settings/keys'
echo -n 'Press [Enter] when finished'
read enter
enter=''

echo 'Cloning dotfiles'
git clone git@github.com:glutaminefree/dotfiles.git
cd dotfiles
cp -r * ..
cd ..
rm -rf dotfiles

echo 'Installing Powerline fonts'
mkdir ~/tmp
cd ~/tmp
git clone https://github.com/powerline/fonts.git fonts
cd fonts
chmod 755 ./install.sh
./install.sh
cd ..
rm -rf fonts
cd ~

echo 'Installing Oh My Zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
mkdir $HOMEPATH/.oh-my-zsh/custom/themes/ -p
cp $HOMEPATH/documents/configs/oh-my-zsh/pygmalion.zsh-theme $HOMEPATH/.oh-my-zsh/custom/themes/pygmalion.zsh-theme

echo 'Installing NeoBundle for Vim'
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

echo 'Disabling Plymouth graphical boot'
sudo dnf remove plymouth
sudo dnf install plymouth
sudo dracut --force

echo 'Copying scripts'
sudo cp $HOMEPATH/documents/scripts/open_with_vim.sh /usr/local/bin/owv
sudo cp $HOMEPATH/documents/scripts/translate.sh     /usr/local/bin/trans
sudo cp $HOMEPATH/documents/scripts/start-urxvt.sh   /usr/local/bin/term
sudo cp $HOMEPATH/documents/scripts/start-gvim.sh    /usr/local/bin/gvimX
sudo chmod 755 /usr/local/bin/owv
sudo chmod 755 /usr/local/bin/trans
sudo chmod 755 /usr/local/bin/term
sudo chmod 755 /usr/local/bin/gvimX

echo 'Done'
echo 'You need to configure Dropbox and Yandex.Disk'
