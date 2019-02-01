source ~/custom.sh
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/Emmanuel/.sdkman"
[[ -s "/Users/Emmanuel/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/Emmanuel/.sdkman/bin/sdkman-init.sh"

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

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
