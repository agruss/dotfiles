export ZSH="$HOME/.oh-my-zsh"

plugins=(git dotnet podman fzf)

ZSH_THEME="fino"
source $ZSH/oh-my-zsh.sh

setopt correct

alias ll="ls -la --color=auto"
alias c="clear"
alias vim="nvim"
