#!/bin/bash

animate_text() {
  local text="Hello, ASCII Animation!"
  local length=${#text}
  local spaces="                                          "  # 42 spasi, sesuaikan dengan panjang teks
  local frame_delay=0.05  # Waktu jeda antar frame

  for ((i = -$length; i <= 42; i++)); do
    clear
    echo -ne "\e[1;33m"  # Warna kuning untuk teks
    echo -ne "${spaces:0:$i}${text}${spaces:$((i + $length))}"
    echo -e "\e[0m"
    sleep $frame_delay
  done
}

# Menjalankan animasi
animate_text

