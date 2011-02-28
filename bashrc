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

# Instead of checking for the existence and location of vim repeatedly, let's do it once and save the results.
if VIMLOC=`which vim 2> /dev/null`; then
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

if [ ! -d ~/.bash_history ] ; then
    mv ~/.bash_history ~/.bash_history_tmp
    mkdir ~/.bash_history 
    mv ~/.bash_history_* ~/.bash_history
fi

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a         #[1]
  HISTFILESIZE=$HISTFILESIZE #[2]
  builtin history -c         #[3]
  builtin history -r         #[4]
}


export HISTFILE="$HOME/.bash_history/`hostname`"




if [ -d ~/bin ] ; then
    PATH="~/bin:${PATH}"
fi

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
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'

alias clr='clear;echo "Currently logged in on $(hostname) : $(tty), as $(whoami) in directory $(pwd)."'



alias dotup="cd ~/dotrc && git pull origin master && cd -"
alias dotpush="cd ~/dotrc && git pull && cd -"
alias dotci="git commit ~/dotrc"

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


# Adapted from Bash-it https://github.com/revans/bash-it/
SCM_THEME_PROMPT_DIRTY=' ✗'
SCM_THEME_PROMPT_CLEAN=' ✓'
SCM_THEME_PROMPT_PREFIX='|'
SCM_THEME_PROMPT_SUFFIX='|'

GIT='git'
SCM_GIT_CHAR='±'

SVN='svn'
SCM_SVN_CHAR='ی'

SCM_NONE_CHAR=''


function scm {
  if [[ -d .git ]]; then SCM=$GIT
  elif [[ -d .svn ]]; then SCM=$SVN
  else SCM='NONE'
  fi
}

function scm_char {
  if [[ -z $SCM ]]; then scm; fi
  [[ $SCM == $GIT ]] && echo $SCM_GIT_CHAR && return
  [[ $SCM == $SVN ]] && echo $SCM_SVN_CHAR && return
  echo $SCM_NONE_CHAR
}

function scm_prompt_info {
  if [[ -z $SCM ]]; then scm; fi
  [[ $SCM == $GIT ]] && git_prompt_info && return
  [[ $SCM == $SVN ]] && svn_prompt_info && return
}

# Stolen from Steve Losh
# left in for backwards-compatibility
function prompt_char {
    char=$(scm_char);
    echo -e "$char"
}


function git_prompt_info {
  prefix=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  suffix=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return

  echo -e " $(scm_char)$prefix${ref#refs/heads/}$state$suffix"
}

function svn_prompt_info {
  prefix=${SVN_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  suffix=${SVN_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
  ref=$(svn info 2> /dev/null | awk -F/ '/^URL:/ { for (i=0; i<=NF; i++) { if ($i == "branches" || $i == "tags" ) { print $(i+1); break }; if ($i == "trunk") { print $i; break } } }') || return

  [[ -z $ref ]] && return
  echo -e " $(scm_char)$prefix$ref$state$suffix"
}

blue=$'\e[0;34m'
black=$'\e[0;30m'
red=$'\e[0;31m'
normal=$'\e[00m'
reset_color=$'\e[39m'
bold_black=$'\e[1;30m'
white=$'\e[1;37m'

xtitle() { [ "$title_seq" ] && printf "$title_seq" "$*"; }


prompt_setter() {
  # Save history
  _bash_history_sync
  PS1="\[$bold_black\]\t \[$white\]\H\[$reset_color\]:\[$red\]\w/\[$reset_color\]$(scm_prompt_info)\[$reset_color\] \\$ "
  PS2='> '
  PS4='+ '
  echo -ne "\033]0;${HOSTNAME}: ${PWD/#$HOME/~}\007"
}

PROMPT_COMMAND=prompt_setter


#export PS1="\[\033[1m\]\H\[\033[0m\]: \[\033[31m\]\w\[\033[32m\]\[\033[0m\] \\$ "


if [ -e /etc/bash_completion ]; then
    source /etc/bash_completion
    complete -F _aptitude install remove

fi 

# Load machine specific data (aws, rcks keys)
if [ -e ~/.bash_local ]; then
    source ~/.bash_local
fi


PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
