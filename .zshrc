source ~/.profile
export PATH="$PATH:/usr/local/bin:~/.local/bin/stack:$HOME/.local/bin:$(which node)"

source $HOME/custom.sh

os="$(uname -s)"

if [[ $os -eq "Darwin" ]]; then
  # install antigen
  if [[ ! -f ~/antigen.zsh ]]; then
    curl -L git.io/antigen > antigen.zsh
  fi

  source ~/antigen.zsh
  antigen use oh-my-zsh
  antigen bundle git
  antigen bundle mafredri/zsh-async
  antigen bundle sindresorhus/pure
  antigen bundle command-not-found
  antigen bundle rupa/z
  # antigen bundle pindexis/marker
  antigen bundle zdharma/fast-syntax-highlighting
  antigen apply
else
  
  source ~/tools/z/z.sh
  source ~/tools/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

# to have a faster completion for git
__git_files () { 
    _wanted files expl 'local files' _files     
}

eval "$(ssh-agent -s)" > /dev/null && ssh-add > /dev/null

alias d="docker"

alias weather="curl http://wttr.in/Lille | less"

alias remoteConnect="/home/dev/projects/RemoteConnect/remoteConnect.sh"

preexec_functions=()

function expand_aliases {
input_command=$1
expanded_command=$2
if [ $input_command != $expanded_command ]; then
    print -nP $PROMPT
    echo $expanded_command
fi
}

alias g='git'

[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && source ~/.dotfiles/fzf.sh
export PATH="/usr/local/bin:$PATH"

alias bubu="brew update && brew upgrade && brew cleanup -s && brew cask cleanup"
alias brdoc="brew doctor && brew missing"
alias cask="brew cask"
alias c="code"
alias ghci='stack ghci --ghci-options "-interactive-print=Text.Pretty.Simple.pPrint" --package pretty-simple'

export PATH="$PATH:$HOME/.rvm/gems/ruby-2.4.0/bin"
alias stack="$HOME/.local/bin/stack"

alias vim="nvim"
alias y="yarn"
alias rm='echo "Use trash-put either"; false'
alias trash='trash-put'
alias ls='exa'
alias la='ls -la'

# Keep at end
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval $(thefuck --alias)
eval "$(direnv hook zsh)"
