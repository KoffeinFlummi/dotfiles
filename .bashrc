export TERM=xterm-256color
export EDITOR=vim
export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF --block-size=M --color=auto --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias sysinfo='echo "" && screenfetch && echo -e "\n" && dfc -p /dev && echo "" && colors'
alias weather='curl http://wttr.in/Darmstadt'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    export ERR=$?
    ~/.prompt.py --right
    PS1=$(~/.prompt.py --left)
}
