#!/bin/bash

while true; do
    echo -e "\nMenu Pilihan:"
    echo "1. GET - Mendapatkan data dari server"
    echo "2. POST - Menambahkan data baru ke server"
    echo "3. PUT - Memperbarui data yang sudah ada di server"
    echo "4. DELETE - Menghapus data dari server"
    echo "0. Exit"

    read -p "Pilih menu (0-4): " choice

    # Validasi input hanya angka 0-4
    if [[ ! $choice =~ ^[0-4]$ ]]; then
        echo "Pilihan tidak valid. Masukkan nomor dari 0 hingga 4."
        continue
    fi

    case $choice in
        1)
            read -p "Masukkan URL/Endpoint: " url
            # Validasi URL menggunakan regex
            if [[ ! $url =~ ^(http|https)://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/[a-zA-Z0-9#?=&.]+)?$ ]]; then
                echo "URL tidak valid. Pastikan format URL benar."
                continue
            fi
            response=$(curl -s $url)
            if [ $? -ne 0 ]; then
                echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
            else
                echo $response | jq .
            fi
            ;;
        2)
            read -p "Masukkan URL/Endpoint: " url
            # Validasi URL menggunakan regex
            if [[ ! $url =~ ^(http|https)://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/[a-zA-Z0-9#?=&.]+)?$ ]]; then
                echo "URL tidak valid. Pastikan format URL benar."
                continue
            fi
            read -p "Masukkan data JSON untuk POST: " data
            response=$(curl -s -X POST -H "Content-Type: application/json" -d "$data" $url)
            if [ $? -ne 0 ]; then
                echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
            else
                echo $response | jq .
            fi
            ;;
        3)
            read -p "Masukkan URL/Endpoint: " url
            # Validasi URL menggunakan regex
            if [[ ! $url =~ ^(http|https)://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/[a-zA-Z0-9#?=&.]+)?$ ]]; then
                echo "URL tidak valid. Pastikan format URL benar."
                continue
            fi
            read -p "Masukkan data JSON untuk PUT: " data
            response=$(curl -s -X PUT -H "Content-Type: application/json" -d "$data" $url)
            if [ $? -ne 0 ]; then
                echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
            else
                echo $response | jq .
            fi
            ;;
        4)
            read -p "Masukkan URL/Endpoint: " url
            # Validasi URL menggunakan regex
            if [[ ! $url =~ ^(http|https)://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/[a-zA-Z0-9#?=&.]+)?$ ]]; then
                echo "URL tidak valid. Pastikan format URL benar."
                continue
            fi
            response=$(curl -s -X DELETE $url)
            if [ $? -ne 0 ]; then
                echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
            else
                echo $response | jq .
            fi
            ;;
        0)
            exit
            ;;
    esac
done

