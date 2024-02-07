#!/bin/bash

while true; do
    # Meminta input dari pengguna
    read -p "Masukkan angka: " bookNumber

    # Melakukan permintaan HTTP dengan menggunakan angka sebagai parameter
    curl "http://localhost:3000/books/$bookNumber" | jq .
    
    # Tambahkan logika untuk keluar dari loop jika diperlukan
    read -p "Lanjut (y/n)? " continueOption
    if [ "$continueOption" != "y" ]; then
        break
    fi
done

