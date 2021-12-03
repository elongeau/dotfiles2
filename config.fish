if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

function dstop
    set containers (docker ps --format "{{.Names}}" | ipt -m)
    echo $containers | xargs docker stop
end

function drm
    set containers (docker ps -f "status=exited" --format "{{.Names}}" | ipt -m)
    echo $containers | xargs docker rm
end

function g
    git $argv
end

function d
    docker $argv
end

function bubu
    brew update
    brew upgrade
    brew cleanup -s
end

function brdoc
    brew doctor
    brew missing
end

function ls
    exa $argv
end

function ll
    ls -l $argv
end

function la
    ls -la $argv
end

function vim
    nvim $argv
end

fish_add_path "/Users/emmanuellongeau/.local/bin"


set -gx GPG_TTY (tty)
