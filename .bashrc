#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/Emmanuel/.sdkman"
[[ -s "/Users/Emmanuel/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/Emmanuel/.sdkman/bin/sdkman-init.sh"

function setProxy {
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

function unsetProxy {
    unset all_proxy
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset no_proxy
    unset NO_PROXY
}

# make bash autocomplete with up arrow
# add to your ~/.profile
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export PATH=$PATH:"/usr/local/bin"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home"

alias vim=nvim

function brewUpdate {
    unsetProxy
    brew update
    brew upgrade
    brew cleanup -s
}

alias bubu=brewUpdate
alias g=git
alias d=docker

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:$HOME/.rvm/bin"
source ~/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASH_IT_THEME="pure"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Emmanuel/projects/gcp/google-cloud-sdk/path.bash.inc' ]; then . '/Users/Emmanuel/projects/gcp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Emmanuel/projects/gcp/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/Emmanuel/projects/gcp/google-cloud-sdk/completion.bash.inc'; fi

eval "$(direnv hook bash)"
. /usr/local/etc/profile.d/z.sh

alias ls=exa

function dstop {
  toStop=$(d ps --format "{{.Names}}" | ipt -m)
  docker stop $toStop
  docker rm $toStop
}

alias dstop="dstop"
alias trash="trash-put"

function cbq {
  docker exec -it $(docker ps  --format "{{.Names}}" | rg couchbase) cbq -e "http://localhost:8091" -u admin -p password -script="$1" -quiet=true
}

function clean_categories {
    echo "* Remove all categories except root"
    cbq "$(cat ~/projects/n1ql/delete_all_category_except_root.n1ql.sql)" >> /dev/null
    echo "* Update root to remove its children"
    cbq "$(cat ~/projects/n1ql/clean_all_children_of_root.sql)" >> /dev/null
}

alias cbq="cbq"
alias clean_categories="clean_categories"