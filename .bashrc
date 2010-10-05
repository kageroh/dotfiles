hh=$HOSTNAME
uu=$USER
col=32
TITLEBAR='\[\033]0; \w\007\]'
PS1="${TITLEBAR}
\[\e[${col}m\]$uu@$hh \[\e[33m\]\w
\[\e[${col}m\]\$\[\e[m\] "

export PATH=/opt/local/bin:/opt/local/sbin/:$HOME/.npm/bin:$PATH
export MANPATH=/opt/local/man:$HOME/.npm/man:$MANPATH
export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias lm='ls -altr'
alias ps='ps aux'

alias ..='cd ..'

alias sass='sass --load-path $HOME/src/sass/'
