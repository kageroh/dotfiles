alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'

alias sass='sass --load-path ~/src/sass/'

PS1="\w $ "

export NODE_PATH=~/.npm/libraries:$NODE_PATH
export PATH=/opt/local/bin:/opt/local/sbin/:~/.npm/bin:$PATH
export MANPATH=/opt/local/man:~/.npm/man:$MANPATH
