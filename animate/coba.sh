#!/bin/bash

spinner_looping() {
    local str=$1
    local width=$(tput cols)
    local delay=0.1

    while [ ! -f "stop_spinner" ]; do
        color_code=$((RANDOM % 7 + 31))  # Warna acak dengan kode warna ANSI
        for ((i = 0; i <= width - ${#str}; i++)); do
            printf "\e[${color_code}m%*s\e[0m%s" $i "" "$str"
            sleep $delay
            printf "\r%*s" $((width + i)) ""  # Membersihkan baris saat pindah ke kanan
        done

        for ((i = width - ${#str}; i >= 0; i--)); do
            printf "\e[${color_code}m%*s\e[0m%s" $i "" "$str"
            sleep $delay
            printf "\r%*s" $((width + i)) ""  # Membersihkan baris saat pindah ke kiri
        done
    done

    rm -f "stop_spinner"  # Membersihkan file penanda setelah loop selesai
}

show_commit_data() {
    spinner_looping "Processing git log..."
    touch "stop_spinner"  # Membuat file penanda untuk menghentikan looping
    #disini proses git
    echo "proses git log"
    sleep 2
    rm -f "stop_spinner"  # Membersihkan file penanda setelah proses selesai
}

# Contoh pemanggilan fungsi dengan parameter
show_commit_data

