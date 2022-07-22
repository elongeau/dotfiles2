export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

plugins=(git docker docker-compose thefuck sbt scala kubectl zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

source /Users/emmanuellongeau/.zsh/fast-syntax-highlighting/F-Sy-H.plugin.zsh
eval $(thefuck --alias)

alias d="docker"
alias dc="docker-compose"
alias dstop='containers=$(docker ps --format "{{.Names}}" | ipt -m); echo $containers | xargs docker stop'
alias drm='containers=$(docker ps -f "status=exited" --format "{{.Names}}" | ipt -m); echo $containers | xargs docker rm'

alias g='git'
alias bubu="brew update && brew upgrade && brew cleanup -s"
alias brdoc="brew doctor && brew missing"
alias cask="brew cask"

alias vim="nvim"
alias trash='trash-put'
alias ls='exa'
alias ll='ls -l'
alias la='ls -la'
alias timeout='gtimeout'

# GIT heart FZF
# -------------
source ~/dotfiles2/fzf.sh
source ~/.secret.sh
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/kubernetes-cli@1.22/bin:/Users/emmanuellongeau/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
eval "$(starship init zsh)"
