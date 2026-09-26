#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias upd='sudo pacman -Syu && paru -Syu'

# PS1='[\u@\h \W]\$ ' (default PS1)
PS1='\W > '

clear
fastfetch --config /home/tema/.config/fastfetch/config.jsonc
. "$HOME/.local/bin/env"
