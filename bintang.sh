#!/bin/bash

spinner_looping() {
    local str=$1
    local width=$(tput cols)
    local delay=0.1
data=">>>>>>>>>>>>>>>>>"
    while true; do
        color_code=$((RANDOM % 7 + 31))  # Warna acak dengan kode warna ANSI
        for ((i = 0; i <= width - ${#str}; i++)); do
            printf "\e[${color_code}m%*s\e[0m%s" $i "" "$str"
            sleep $delay
            clear
            printf "\r%*s" $((width + i)) ""  # Membersihkan baris saat pindah ke kanan
        done

        for ((i = width - ${#str}; i >= 0; i--)); do
            printf "\e[${color_code}m%*s\e[0m%s" $i "" "$str"
            sleep $delay
            clear
            spinner_looping "$data"
          
            printf "\r%*s" $((width + i)) ""  # Membersihkan baris saat pindah ke kiri
        done
    done
}

# Contoh pemanggilan fungsi dengan parameter
clear
spinner_looping "Sedang di proses bro"


# 1. jangan lupa subscribe dan screen shot kirim wa
# -082140014494 cak lolong
# -boleh request script:
# -shell/bash
# -python
# -javascript 
# -php
# -web phising facebook responsive
# -wes ngono ae. salam teko arek Suroboyo, pakis.
