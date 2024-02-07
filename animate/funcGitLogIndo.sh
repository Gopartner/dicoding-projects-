#!/bin/bash

# Fungsi spinner untuk menampilkan animasi dengan string masukan di tengah layar
spinner() {
    local str=$1
    local colors=("\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    
    # Mendapatkan lebar dan tinggi terminal
    local width=$(tput cols)
    
    # Menampilkan teks dan animasi spinner di tengah-tengah layar
    printf "%*s" $(( (width - ${#str} ) / 2))  # Menempatkan teks dan spinner di tengah-tengah
    for ((i = 0; i < ${#str}; i++)); do
        # Menyusun animasi dengan menggabungkan warna dan karakter
        echo -ne "${colors[$i]}${str:$i:1}\e[0m"  # Menampilkan karakter dengan warna
        sleep 0.1  # Menambahkan jeda untuk animasi
    done

    echo  # Pindah ke baris baru setelah selesai
}

# Contoh pemanggilan fungsi dengan parameter
# spinner "Spinner Baru"

# ========== batas spinner jalan sekali ========

spinner() {
    local str=$1
    local colors=("\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m" "\e[1;37m" "\e[1;31m" "\e[1;32m" "\e[1;33m" "\e[1;34m" "\e[1;35m" "\e[1;36m")
    
    # Mendapatkan lebar dan tinggi terminal
    local width=$(tput cols)
    
    # Menampilkan teks dan animasi spinner di tengah-tengah layar
    printf "%*s" $(( (width - ${#str} ) / 2))  # Menempatkan teks dan spinner di tengah-tengah
    for ((i = 0; i < ${#str}; i++)); do
        # Menyusun animasi dengan menggabungkan warna dan karakter
        echo -ne "${colors[$i]}${str:$i:1}\e[0m"  # Menampilkan karakter dengan warna
        sleep 0.1  # Menambahkan jeda untuk animasi
    done

    echo  # Pindah ke baris baru setelah selesai
}

# Looping contoh


# ========= batas Spinner looping terus ========

# Fungsi untuk mengonversi nama hari dan bulan ke dalam bahasa Indonesia
translate() {
  local english_text="$1"
  case "$english_text" in
    "Mon") echo "Senin" ;;
    "Tue") echo "Selasa" ;;
    "Wed") echo "Rabu" ;;
    "Thu") echo "Kamis" ;;
    "Fri") echo "Jumat" ;;
    "Sat") echo "Sabtu" ;;
    "Sun") echo "Minggu" ;;
    "Jan") echo "Januari" ;;
    "Feb") echo "Februari" ;;
    "Mar") echo "Maret" ;;
    "Apr") echo "April" ;;
    "May") echo "Mei" ;;
    "Jun") echo "Juni" ;;
    "Jul") echo "Juli" ;;
    "Aug") echo "Agustus" ;;
    "Sep") echo "September" ;;
    "Oct") echo "Oktober" ;;
    "Nov") echo "November" ;;
    "Dec") echo "Desember" ;;
    *) echo "$english_text" ;;
  esac
}

# Fungsi untuk menampilkan data dalam bentuk objek JSON dengan format tanggal bahasa Indonesia
format_commit_date() {
  local commit_date="$1"
  local translated_day=$(translate "$(echo "$commit_date" | cut -d' ' -f1)")
  local translated_month=$(translate "$(echo "$commit_date" | cut -d' ' -f2)")
  local commit_time=$(echo "$commit_date" | cut -d' ' -f4)
  local translated_date="$translated_day $translated_month $(echo "$commit_date" | cut -d' ' -f3) tahun jam $commit_time"
  echo "$translated_date"
}

get_commit_hashes() {
  git log --pretty=format:'%h'
}

get_commit_message() {
  local hash="$1"
  git log -1 --pretty=format:'%B' "$hash"
}

get_commit_author() {
  local hash="$1"
  git log -1 --pretty=format:'%an' "$hash"
}

# Fungsi untuk membuat objek JSON dari commit
create_commit_json() {
  local hash="$1"
  local commit_message="$2"
  local commit_author="$3"
  local commit_date="$4"

  local commit_json='{
    "hash": "'"$hash"'",
    "message": "'"$commit_message"'",
    "author": "'"$commit_author"'",
    "date": "'"$commit_date"'"
  }'

  echo "$commit_json"
}

# Menampilkan data dari semua commit
show_commit_data() {
  spinner "Processing git log..."

  local commit_hashes=($(get_commit_hashes))

  # Membuat objek JSON dari setiap commit
  local json_data='['
  for hash in "${commit_hashes[@]}"; do
    local commit_message=$(get_commit_message "$hash")
    local commit_author=$(get_commit_author "$hash")
    local commit_date=$(git log -1 --date=format:'%a %b %d %H:%M:%S %Y' --pretty=format:'%cd' "$hash")
    local formatted_date=$(format_commit_date "$commit_date")

    local commit_json=$(create_commit_json "$hash" "$commit_message" "$commit_author" "$formatted_date")
    json_data="$json_data$commit_json,"
  done

  # Menghapus koma terakhir dan menutup array JSON
  json_data="${json_data%,}]"

  # Spinner loop
  jumlah_data=$(echo "$json_data" | jq 'length')
  counter=0
  while [ $counter -lt $jumlah_data ]; do
    spinner "$(echo "$counter")"
    sleep 1 
    clear
    ((counter++))
  done

  echo "$json_data" | jq .
}

# Menampilkan data dari semua commit

show_commit_data

 
# Memeriksa apakah jq terinstal
if ! command -v jq &> /dev/null; then
    echo "jq tidak terinstal. Silakan instal jq untuk menjalankan skrip ini."
    exit 1
fi



for ((counter = 1; counter <= 4; counter++)); do
    case $counter in
        1)
            spinner "Proses git log sudah selesai"
            ;;
        2)
            spinner "Hash: untuk kembali ke commit tertentu."
            ;;
        3)
            spinner "Author: nama akun repository"
            ;;
        4)
            spinner "message: pesan commit"
            ;;
    esac
done

spinner "Jangan lupa subscribe ya bosku!!!"


# Salam kenal dari suroboyo.
# Cak Plolong arek pakis gunung 1c-7b RT13-RW004
# Info tukang banguna/website wa: 082140014494

