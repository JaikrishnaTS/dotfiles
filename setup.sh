#!/bin/bash

BASH_PROFILE=".bash_profile"
TMUX_CONF=".tmux.conf"
VIMRC=".vimrc"
I3_CONF=".config/i3/config"

## Setup bash
function setup_bash() {
    cp .bash_profile $HOME/.bash_profile
}

## Setup tmux
function setup_tmux() {
    # copy tmux conf
    cp ${TMUX_CONF} $HOME/${TMUX_CONF}

    # create dirs
    mkdir -p $HOME/.tmux/plugins

    # setup tpm - git will fail & bash continues if already existing
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

    # install plugins
    $HOME/.tmux/plugins/tpm/bin/install_plugins
}

## Setup vim
function setup_vim() {
    # copy .vimrc file and .vim
    cp ${VIMRC} $HOME/${VIMRC}
    cp -r .vim $HOME/

    # create dirs
    mkdir -p $HOME/.vim/colors $HOME/.vim/backup $HOME/.vim/swp $HOME/.vim/autoload

    # setup vim-plug
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O $HOME/.vim/autoload/plug.vim

    # install the plugins through vim-plug
    vim +PlugInstall +qall
}

function setup_i3() {
    SEP="^#LOCAL_CHANGES$"
    REPO_FILE=${I3_CONF}
    LOCAL_FILE=$HOME/${REPO_FILE}
    TEMP_FILE=merge.tmp

    sed -e "/${SEP}/q" ${REPO_FILE} > ${TEMP_FILE}
    sed -e "0,/${SEP}/d" ${LOCAL_FILE} >> ${TEMP_FILE}
    diff ${LOCAL_FILE} ${TEMP_FILE}
    mv ${TEMP_FILE} ${LOCAL_FILE}
}

function diff_cfg() {
    case $1 in
        i3)
            diff ${I3_CONF} $HOME/${I3_CONF}
            ;;
        tmux)
            diff ${TMUX_CONF} $HOME/${TMUX_CONF}
            ;;
        vim)
            diff ${VIMRC} $HOME/${VIMRC}
            ;;
        bash)
            diff ${BASH_PROFILE} $HOME/${BASH_PROFILE}
            ;;
        *)
            echo "Enter one of i3 tmux vim bash"
            ;;
    esac
}
