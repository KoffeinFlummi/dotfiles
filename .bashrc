export TERM=xterm-256color
export EDITOR=vim

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alhF --color=auto --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias fd="fd --hidden"

alias sysinfo='echo "" && screenfetch && echo -e "\n" && dfc -p /dev && echo "" && colors'
alias weather='curl http://wttr.in/Darmstadt'
alias hexocom='picocom --imap spchex,tabhex,crhex,lfhex,8bithex,nrmhex'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    export ERR=$?
    prompt-rs --right
    PS1=$(prompt-rs --left)
}

export MYSQL_HISTFILE=/dev/null
export LESSHISTFILE=/dev/null
export ANDROID_HOME=/opt/android-sdk
export NOTES_DIRECTORY=~/Documents/notes

PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:~/.cargo/bin
