#
# ~/.bashrc
#



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set -o vi

#alias ls='ls --color=auto'
alias ls='exa --icons'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='\u@\h \W \$ '

 PS1='$(if [[ $? -eq 0 ]]; then echo "\[\e[97m\]▍"; else echo "\[\e[38;5;196m\]▍"; fi) \[\e[97m\]\u@\h \w \[\e[97m\]λ \[\e[0m\]'


#PS1='$(if [[ $? -eq 0 ]]; then if [[ $VI_MODE == "insert" ]]; then echo "\[\e[38;5;76m\]▍"; else echo "\[\e[38;5;27m\]▍"; fi; else echo "\[\e[38;5;196m\]▍"; fi) \[\e[97m\]\u@\h \w \[\e[97m\]λ \[\e[0m\]'


export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:/your/folder/path"


eval "$(zoxide init bash)"  # For bash 
alias cd="z"

alias cl="xclip -selection clipboard"

alias ghgr="/usr/bin/python /home/lich/scripts/ghgraphterm.py"

# gruvbox-dark theme
# url github.com/raindeer44/gruvbox-tty
# raindeer44 <github.com/raindeer44>
# based on gruvbox.vim by morhetz <github.com/morhetz>
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0282828" #bg0
    echo -en "\e]P8928374" #grey
    echo -en "\e]P1cc241d" #darkred
    echo -en "\e]P9fb4934" #red
    echo -en "\e]P298971a" #darkgreen
    echo -en "\e]PAb8bb26" #green
    echo -en "\e]P3d79921" #darkyellow
    echo -en "\e]PBfabd2f" #yellow
    echo -en "\e]P4458588" #darkblue
    echo -en "\e]PC83a598" #blue
    echo -en "\e]P5b16286" #darkmagenta
    echo -en "\e]PDd3869b" #magenta
    echo -en "\e]P6689d6a" #darkcyan
    echo -en "\e]PE8ec07c" #cyan
    echo -en "\e]P7a89984" #fg4
    echo -en "\e]PFebdbb2" #fg1
    clear #for background artifacting
fi

