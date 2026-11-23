# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

PS1='[\u@\h \W]\$ '

# Gaming optimizations
export MANGOHUD=1
export MANGOHUD_CONFIG=font_size=24,position=top-right
export GAMESCOPE_GAMING=1

# Flatpak
export PATH="/var/lib/flatpak/exports/bin:$PATH"