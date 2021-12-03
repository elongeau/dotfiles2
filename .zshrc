# source ~/.profile
zmodload zsh/zprof

os="$(uname -s)"


### Added by Zplugin's installer
# source "$HOME/.zplugin/bin/zplugin.zsh"
# autoload -Uz _zplugin
# (( ${+_comps} )) && _comps[zplugin]=_zplugin
# ### End of Zplugin installer's chunk
# zplugin ice wait'0'

# zplugin ice blockf
# zplugin light zsh-users/zsh-autosuggestions
# zplugin light zdharma/fast-syntax-highlighting
# zplugin load zsh-users/zsh-history-substring-search
# zplugin ice from"gh-r" as"program"
# zplugin load junegunn/fzf-bin
# zplugin load lukechilds/zsh-nvm
# # zplugin ice depth=1; zplugin light romkatv/powerlevel10k
__git_files () { 
    _wanted files expl 'local files' _files     
}

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(zsh-nvm fast-syntax-highlighting )

# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

alias d="docker"
alias dc="docker-compose"

function expand_aliases {
input_command=$1
expanded_command=$2
if [ $input_command != $expanded_command ]; then
    print -nP $PROMPT
    echo $expanded_command
fi
}

alias g='git'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && source ~/.dotfiles/fzf.sh
export PATH="/Users/emmanuellongeau/.local/bin:/usr/local/bin:$PATH"
export GITHUB_TOKEN="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"

alias bubu="brew update && brew upgrade && brew cleanup -s"
alias brdoc="brew doctor && brew missing"
alias cask="brew cask"

alias vim="nvim"
alias trash='trash-put'
alias ls='exa'
alias ll='ls -l'
alias la='ls -la'
alias timeout='gtimeout'
eval "$(direnv hook zsh)"

HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

alias dstop='containers=$(docker ps --format "{{.Names}}" | ipt -m); echo $containers | xargs docker stop'
alias drm='containers=$(docker ps -f "status=exited" --format "{{.Names}}" | ipt -m); echo $containers | xargs docker rm'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH="$PATH:$HOME/go/bin/"
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/emmanuellongeau/.sdkman"
[[ -s "/Users/emmanuellongeau/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/emmanuellongeau/.sdkman/bin/sdkman-init.sh"

# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/*.zsh.inc

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

# gh() {
#   is_in_git_repo || return
#   git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
#   fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
#     --header 'Press CTRL-S to toggle sort' \
#     --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
#   grep -o "[a-f0-9]\{7,\}"
# }

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
# bind-git-helper f b t r
# unset -f bind-git-helper

alias gp='eval "GCP_PROJECT=$(gcloud projects list | sed "1d" | cut -d" " -f1 | fzf)"'
alias gs="gcloud config configurations list | sed '1d' | cut -d' ' -f1 | ipt | xargs gcloud config configurations activate && gp"
alias lm='go-to-lm'
export PATH="~/tools/confluent/bin:$PATH"

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="/Users/emmanuellongeau/projects/lm/confluent-5.3.0/bin:$PATH"
export EDITOR=nvim
alias ccd='cd $(ls -D -1 . | fzf)'
alias ssh-acc='cp ~/.ssh/$(ls -D1 ~/.ssh | ipt)/* ~/.ssh && eval `$(ssh-agent -s)`'
eval "$(starship init zsh)"

alias update-me="bubu; gcloud components update; cask outdated | cut -f 1 | xargs brew cask reinstall; sdk update; tldr --update"
alias m=make
export PATH="$PATH:/usr/local/bin/elixir"
source /Users/emmanuellongeau/.nix-profile/etc/profile.d/nix.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export NIX_IGNORE_SYMLINK_STORE=1
export GPG_TTY=$(tty)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/emmanuellongeau/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/emmanuellongeau/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/emmanuellongeau/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/emmanuellongeau/tools/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(zoxide init zsh)"

source /Users/emmanuellongeau/.config/broot/launcher/bash/br
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh