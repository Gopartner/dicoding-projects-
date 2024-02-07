#!/bin/bash

# Fungsi untuk mengonversi nama hari ke dalam bahasa Indonesia
translate_day() {
  local english_day="$1"
  case "$english_day" in
    "Mon") echo "Senin" ;;
    "Tue") echo "Selasa" ;;
    "Wed") echo "Rabu" ;;
    "Thu") echo "Kamis" ;;
    "Fri") echo "Jumat" ;;
    "Sat") echo "Sabtu" ;;
    "Sun") echo "Minggu" ;;
    *) echo "$english_day" ;;
  esac
}

# Fungsi untuk mengonversi nama bulan ke dalam bahasa Indonesia
translate_month() {
  local english_month="$1"
  case "$english_month" in
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
    *) echo "$english_month" ;;
  esac
}

# Fungsi untuk menampilkan data dalam bentuk objek JSON dengan format tanggal bahasa Indonesia
show_commit_data() {
  local commit_hashes=($(git log --pretty=format:'%h'))

  # Membuat objek JSON dari setiap commit
  local json_data='['
  for hash in "${commit_hashes[@]}"; do
    local commit_message=$(git log -1 --pretty=format:'%B' $hash)
    local commit_author=$(git log -1 --pretty=format:'%an' $hash)
    local commit_date=$(git log -1 --date=format:'%a %b %d %H:%M:%S %Y' --pretty=format:'%cd' $hash)

    # Mengonversi nama hari dan bulan ke dalam bahasa Indonesia
    local translated_day=$(translate_day "$(echo $commit_date | cut -d' ' -f1)")
    local translated_month=$(translate_month "$(echo $commit_date | cut -d' ' -f2)")

    local commit_time=$(echo $commit_date | cut -d' ' -f4)
    local translated_date="$translated_day $translated_month $(echo $commit_date | cut -d' ' -f3) tahun jam $commit_time"

    local commit_json='{
      "hash": "'"$hash"'",
      "message": "'"$commit_message"'",
      "author": "'"$commit_author"'",
      "date": "'"$translated_date"'"
    }'

    json_data="$json_data$commit_json,"
  done

  # Menghapus koma terakhir dan menutup array JSON
  json_data="${json_data%,}]"

  echo $json_data | jq .
}

# Menampilkan data dari semua commit
show_commit_data

