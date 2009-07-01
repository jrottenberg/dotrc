# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# $Date: 2008-02-29 00:47:45 -0500 (Fri, 29 Feb 2008) $
# $Author: ju $


export GREP_OPTIONS='--color=auto'

source /etc/bash_completion

# History stuff
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '

#  The ‘New Window’ Problem (bonus get a fancy title bar)
shopt -s histappend
PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD/$HOME/~}\007";history -a;history -n'
if [ -d ~/bin ] ; then
    PATH="~/bin:${PATH}"
fi

PAGER="less"
LESS="-niSRFX"  # n supppres line numbers
                # i search ignores case
                # S scroll horizontally
                # R interpret color escape sequences
                # F quit if one screen
                # X no init


# mysql nice promp user@server : schema
export MYSQL_PS1="(\u@\h):[\d]> "
alias mysql="mysql --pager"


    # enable color support of ls and also add handy aliases
    eval `dircolors -b`
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    # some more ls aliases
    alias ll='ls -la'
    alias la='ls -A'
    alias lh='ls -lah'
    alias l='ls -CF'
    alias h='history'	

alias search='aptitude search'
alias show='aptitude show'
alias install='sudo aptitude install'
alias remove='sudo aptitude remove'
alias update='sudo apt-get update'
alias upgrade='sudo aptitude safe-upgrade'
alias tgz='tar -cvvzf'
alias tbz2='tar -cvvjf'
alias utgz='tar -xvvzf'
alias utbz2='tar -xvvjf'
alias mktar='tar -cvvf'
alias untar='tar -xvvf'
alias clr='clear;echo "Currently logged in on $(hostname) : $(tty), as $(whoami) in directory $(pwd)."'



alias dotup="git pull ~/dotrc"
alias dotci="git commit ~/dotrc"

    # If this is an xterm set the title to user@host:dir
    case $TERM in
    midpssh)
        export LANG=en_US.ISO-8859-1 # etc...
        ;;
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD/$HOME/~}\007"'
        ;;
    *)
        ;;
    esac


PS1='\[\033[1m\]\H\[\033[0m\]: \[\033[31m\]$PWD\[\033[32m\]\[\033[0m\] \\$ '
