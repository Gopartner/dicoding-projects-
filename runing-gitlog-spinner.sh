#!/bin/bash

spinner() {
    local str=$1
    local colors=("\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m")

    local width=$(tput cols)
    printf "%*s" $(( (width - ${#str} ) / 2))
    for ((i = 0; i < ${#str}; i++)); do
        echo -ne "${colors[$i]}${str:$i:1}\e[0m"
        sleep 0.1
    done
    echo
}

run_git_log_with_spinner() {
    local is_running=true
    local temp_file=$(mktemp)
    local pid_spinner

    spinner "Running Git Log" &
    pid_spinner=$!

    (git log --oneline --decorate --color=always > "$temp_file" && is_running=false) &

    while $is_running; do
        sleep 0.1
    done

    kill $pid_spinner
    cat "$temp_file"
    rm "$temp_file"
}

run_git_log_with_spinner

