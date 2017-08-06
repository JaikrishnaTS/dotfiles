#!/bin/bash

## Setup bash
wget https://raw.githubusercontent.com/JaikrishnaTS/dotfiles/master/.bash_profile -O $HOME/.bash_profile

## Setup vim
# download .vimrc file
wget https://raw.githubusercontent.com/JaikrishnaTS/dotfiles/master/.vimrc -O $HOME/.vimrc

# create dirs
mkdir -p $HOME/.vim/colors $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/autoload

# setup vim-plug
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O $HOME/.vim/autoload/plug.vim

# install the plugins through vim-plug
vim +PlugInstall +qall

## Setup tmux
# download tmux conf
wget https://raw.githubusercontent.com/JaikrishnaTS/dotfiles/master/.tmux.conf -O $HOME/.tmux.conf

# create dirs
mkdir -p $HOME/.tmux/plugins

# setup tpm - git will fail & bash continues if already existing
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# install plugins
$HOME/.tmux/plugins/tpm/bin/install_plugins
