source ~/.profile
export PATH="$PATH:/usr/local/bin:~/.local/bin/stack:/Users/Emmanuel/.local/bin:$(which node)"
# export ALL_PROXY=gateway.zscaler.net:80
# export HTTP_PROXY=gateway.zscaler.net:80
# export HTTPS_PROXY=gateway.zscaler.net:443
# export http_proxy=$HTTP_PROXY
# export https_proxy=$HTTPS_PROXY
# # Docker proxy
# export no_proxy='localhost, 127.0.0.1, .cube-net.org'
# export NO_PROXY=$no_proxy

setProxy(){
    export all_proxy=socks://gateway.zscaler.net:80
    export http_proxy=http://gateway.zscaler.net:80
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export ALL_PROXY=$all_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export no_proxy="localhost, 127.0.0.1, .cube-net.org"
    export NO_PROXY=$no_proxy
}

unsetProxy(){
   PROXY_ENV=( \
      "http_proxy" "ftp_proxy" "https_proxy" "all_proxy" \
      "HTTP_PROXY" "HTTPS_PROXY" "FTP_PROXY" "ALL_PROXY" \
      "NO_PROXY"\
   )
    for envar in ${PROXY_ENV[@]}
    do
       unset $envar
    done
}

setProxy

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
  
  source ~/.localconfrc
  alias sync-time='sudo /usr/sbin/VBoxService --timesync-set-start > /dev/null'
  source ~/tools/z/z.sh
  source ~/tools/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

# to have a faster completion for git
__git_files () { 
    _wanted files expl 'local files' _files     
}

eval "$(ssh-agent -s)" > /dev/null && ssh-add > /dev/null

function setTask() {
echo "Task $1 : " > /opt/dev/jazzws/CUBE-Dev/.git/.gitmessage
}
function setDefect() {
echo "Defect $1 : " > /opt/dev/jazzws/CUBE-Dev/.git/.gitmessage
}

alias setTask="setTask"
alias setDefect="setDefect"

alias ant='cant'
function cant {
"ant" -logger org.apache.tools.ant.listener.AnsiColorLogger "$@" \
    2>&1 | perl -pe 's/(?<=\e\[)2;//g'
}
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
export NO_PROXY=",*.cube-net.org,localhost,*.cube.ntt.preprod.org"
alias cask="brew cask"
alias c="code"
alias ghci='stack ghci --ghci-options "-interactive-print=Text.Pretty.Simple.pPrint" --package pretty-simple'

export PATH="$PATH:/Users/Emmanuel/.rvm/gems/ruby-2.4.0/bin"
alias stack="/Users/Emmanuel/.local/bin/stack"

alias vim="nvim"
alias rtc="cat ~/.rtc | pbcopy"
alias y="yarn"

# Keep at end
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval "$(direnv hook zsh)"
