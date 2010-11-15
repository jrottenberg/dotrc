# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# $Author: Julien Rottenberg <julien+GITHUB@rottenberg.info>$


export GREP_OPTIONS='--color=auto'

## shopt FTW
# Adjust terminal size on move
shopt -s checkwinsize
#  The ‘New Window’ Problem (bonus get a fancy title bar)
shopt -s histappend
# Auto correct folders... no more cd /ect/...
shopt -s cdspell


export EDITOR=vi
# History stuff
export HISTCONTROL=ignoreboth

export HISTTIMEFORMAT='%F %T '

# Nicer output for time commands
#  $ time sleep 5
#
#
# Elapsed time   : 0m5.001s
# User mode      : 0m0.000s
# System mode    : 0m0.000s
# CPU percentage : 0.00

TIMEFORMAT="

Elapsed time   : %3lR
User mode      : %3lU
System mode    : %3lS
CPU percentage : %P"


if [ ! -d ~/.bash_history ] ; then
    mv ~/.bash_history ~/.bash_history_tmp
    mkdir ~/.bash_history 
    mv ~/.bash_history_* ~/.bash_history
fi
export HISTFILE="$HOME/.bash_history/`hostname`"


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


export PS1="\[\033[1m\]\H\[\033[0m\]: \[\033[31m\]\w\[\033[32m\]\[\033[0m\] \\$ "


if [ -e /etc/bash_completion ]; then
    source /etc/bash_completion
    complete -F _aptitude install remove

fi 

# Spelling when running cd
set cdspell


PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

