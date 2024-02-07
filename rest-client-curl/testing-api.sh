#!/bin/bash

clear

url=""
changeEndpoint=false
autoIncrementId=1

while true; do
    echo -e "\t\t\t\nCRUD JAVASVRIPT:"
    echo "1. GET - Mendapatkan data dari server"
    echo "2. POST - Menambahkan data baru ke server"
    echo "3. PUT - Memperbarui data yang sudah ada di server"
    echo "4. DELETE - Menghapus data dari server"
    echo "5. Ganti Endpoint"
    echo "0. Exit"

    read -p "Pilih menu (0-5): " choice

    # Validasi input hanya angka 0-5
    if [ "$choice" -lt 0 ] || [ "$choice" -gt 5 ]; then
        echo "Pilihan tidak valid. Masukkan nomor dari 0 hingga 5."
        continue
    fi

    if [ "$choice" -eq 0 ]; then
        exit
    elif [ "$choice" -eq 5 ]; then
        read -p "Masukkan URL/Endpoint: " url
        changeEndpoint=true
    fi

    if [ "$changeEndpoint" = false ]; then
        # Validasi URL hanya jika tidak ada perintah untuk mengganti endpoint
        if [ -z "$url" ]; then
            read -p "Masukkan URL/Endpoint: " url
        fi

        # Validasi URL menggunakan regex
        if ! echo "$url" | grep -E '^(http|https)://[a-zA-Z0-9.-]+:[0-9]+/[a-zA-Z0-9#?=&.]+' >/dev/null; then
            echo "URL tidak valid. Pastikan format URL benar."
            continue
        fi
    fi

    case $choice in
        1)
            response=$(curl -s "$url")
            if [ $? -ne 0 ]; then
                echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
            else
                clear
                echo "$response" | jq . || echo "Gagal memproses output dengan jq."
            fi
            ;;
        2)
            echo "Masukkan data POST:"
            read -p "Title (judul buku): " title
            read -p "Author (penulis): " author

            # Menampilkan proses spinner warna hijau
            printf "Menambahkan data... "
            for i in {1..10}; do
                printf "."
                sleep 0.2
            done
            echo -e "\n"

            response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"id\": $autoIncrementId, \"title\": \"$title\", \"author\": \"$author\"}" "$url")

            if [ $? -eq 0 ]; then
                echo "================"
                echo "$response" | jq .
                echo "================"
                echo "Data berhasil ditambahkan."
                ((autoIncrementId++))  # Increment ID
            else
                echo "Gagal menambahkan data. Periksa koneksi atau coba lagi."
            fi
            ;;
        3)
            read -p "Masukkan data JSON untuk PUT: " data
            response=$(curl -s -X PUT -H "Content-Type: application/json" -d "$data" "$url")
            ;;
        4)
            response=$(curl -s -X DELETE "$url")
            ;;
    esac

    if [ $? -ne 0 ]; then
        echo "Gagal mengirim permintaan ke server. Periksa koneksi atau coba lagi."
    elif [ $choice -ne 1 ] && [ $choice -ne 2 ]; then
        echo "$response" | jq .
    fi
done

