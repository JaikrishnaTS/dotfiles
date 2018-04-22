PS1="\$? [\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \W]\\$ \[$(tput sgr0)\]"

# set EDITOR
export EDITOR='/usr/bin/vim'
alias editor=$EDITOR

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lz='ls -Z'
alias mux='exec tmux new-session -A -s tmux'

alias vdiff='vimdiff'

# vim Man page
vman() {
    vim -c "Man $1 $2" -c 'silent only'
}
_vman () {
    _completion_loader man
    _man
}
complete -F _vman vman

fixssh() {
    eval $(tmux show-env -s |grep '^SSH_AUTH_SOCK')
}

if command -v tmux>/dev/null; then
    if [[ $TERM =~ xterm ]] && [ -z $TMUX ]; then
        exec tmux new-session -A -s tmux
    fi
fi
