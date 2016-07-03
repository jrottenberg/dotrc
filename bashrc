# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# $Author: Julien Rottenberg <julien+GITHUB@rottenberg.info>$


export GREP_OPTIONS='--color=auto'

## shopt FTW
# Adjust terminal size on move
shopt -s checkwinsize
# Auto correct folders... no more cd /ect/...
shopt -s cdspell

# Instead of checking for the existence and location of vim repeatedly, let's do it once and save the results.
if type -t vim > /dev/null; then
  EDITOR=vim
  alias vi=vim
else
  EDITOR=vi
fi


export EDITOR

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


# History stuff
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=9000
export HISTFILESIZE=$HISTSIZE

export LESS="-niSRFX"  # n supppres line numbers
                # i search ignores case
                # S scroll horizontally
                # R interpret color escape sequences
                # F quit if one screen
                # X no init

export PAGER="less"

# mysql nice promp user@server : schema
export MYSQL_PS1="(\u@\h):[\d]> "
alias mysql="mysql --pager"


# enable color support of ls and also add handy aliases
export CLICOLOR=1
alias dir='ls  --format=vertical'
alias vdir='ls  --format=long'
alias ll='ls -la'
alias la='ls -A'
alias lh='ls -lah'
alias l='ls -CF'

alias h='history'
bind -x '"\C-l":ls -l'

alias search='aptitude search'
alias show='aptitude show'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias uu='update && upgrade'

alias clr='clear;echo "Currently logged in on $(hostname) : $(tty), as $(whoami) in directory $(pwd)."'


alias dotup="cd ~/dotrc && git pull origin master && cd -"
alias dotpush="cd ~/dotrc && git push origin master  && cd -"
alias dotci="git commit ~/dotrc"

# http://unix.stackexchange.com/a/25329
alias watch='watch '

# If this is an xterm set the title to host:dir
# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
case $TERM in
  [xkE]term*|rxvt*|cygwin)
    title_seq="\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"

    #title_seq='\e]0;%s\007'
    ;;
  screen*)
    # only set the "screen"window title
    title_seq='\ek%s\e\\'
    ;;
  *)
    title_seq=''
    ;;
esac


blue=$'\e[0;34m'
black=$'\e[0;30m'
red=$'\e[0;31m'
normal=$'\e[00m'
reset_color=$'\e[39m'
bold_black=$'\e[1;30m'
white=$'\e[1;37m'

xtitle() { [ "$title_seq" ] && printf "$title_seq" "$*"; }

alias c=' printf "\33[2J"'


# Load machine specific data (aws, rcks keys)
if [ -e ~/.bash_local ]; then
    source ~/.bash_local
fi

if type -t gem > /dev/null
    then PATH=${PATH}:$(gem env gemdir)/bin
fi

if [ -d ~/bin ] ; then
    PATH="~/bin:${PATH}"
fi


PATH=${PATH}:/usr/local/sbin:/usr/sbin:/sbin


if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

complete -C aws_completer aws

alias bb='brew update && brew upgrade && brew list > ~/Dropbox/mac_install/brew.lst'
alias bbcast='brew cask update && brew cask list > ~/Dropbox/mac_install/brew-cask.lst'

export DOCKER_HOST=unix:///var/run/docker.sock
export BUILD_NUMBER=0
