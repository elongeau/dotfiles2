export FZF_DEFAULT_OPTS='
  --height 40% --reverse --border
  --ansi
  --reverse --inline-info
  '


# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

ggf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

ggb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort -r |
  fzf --ansi --multi --tac |
  # fzf-down --ansi --multi --tac --preview-window right:30% \
  #   --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

ggt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

ggh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

ggr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "	" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'	' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-gg$c-widget() { local result=\$(gg$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-gg$c-widget"
    eval "bindkey '^g^$c' fzf-gg$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

# join_lines() {
#   local item
#   while read item; do
#     echo -n "${(q)item} "
#   done
# }


# fzf-ggf-widget() LBUFFER+=$(ggf | join_lines)
# zle -N fzf-ggf-widget
# bindkey '^g^f' fzf-ggf-widget

fzf-ggb-widget() # LBUFFER+=$(ggb | join_lines)
{ local result=$(ggb | join-lines); zle reset-prompt; LBUFFER+=$result }
zle -N fzf-ggb-widget
bindkey '^g^b' fzf-ggb-widget


# fzf-ggh-widget() LBUFFER+=$(ggh | join_lines)
# zle -N fzf-ggh-widget
# bindkey '^g^h' fzf-ggh-widget


# fzf-ggr-widget() LBUFFER+=$(ggr | join_lines)
# zle -N fzf-ggr-widget
# bindkey '^g^r' fzf-ggr-widget


# fzf-ggt-widget() LBUFFER+=$(ggt | join_lines)
# zle -N fzf-ggt-widget
# bindkey '^g^t' fzf-ggt-widget
export FZF_DEFAULT_OPTS='
  --height 40% --reverse --border
  --ansi
  --reverse --inline-info
  '

