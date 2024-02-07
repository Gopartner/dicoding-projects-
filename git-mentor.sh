#!/bin/bash

color() {
  local text="$1"
  local color_code="$2"

  case $color_code in
    "1") echo -e "\e[32m$text\e[0m" ;;  # Hijau
    "2") echo -e "\e[33m$text\e[0m" ;;  # Kuning
    "3") echo -e "\e[34m$text\e[0m" ;;  # Biru
    "4") echo -e "\e[35m$text\e[0m" ;;  # Ungu
    "5") echo -e "\e[36m$text\e[0m" ;;  # Cyan
    "6") echo -e "\e[31m$text\e[0m" ;;  # Merah
    "7") echo -e "\e[31;43m$text\e[0m" ;;  #redBgy
    "8") echo -e "\e[1;34m$text\e[0m" ;;  # LBlue
    "9") echo -e "\e[1;37m$text\e[0m" ;;  # Lwhite
    "10") echo -e "\e[1;30m$text\e[0m" ;; #LGrey
    "11") echo -e "\e[41m$text\e[0m" ;;   # BgRed
    "0") echo -e "\e[36m$text\e[0m" ;;   # Cyan
    *) echo "$text" ;;
  esac
}

## ========== endfor function color ==========

## untuk pesan commit dengan waktu dinamis
commit_with_dynamic_comment() {
  local current_time=$(date +"%H:%M:%S-%m-%d-%Y")
  git commit -m "Commit on: $current_time"
}

# ========= memberi warna pada info menu ========

Status="View status (git status)"
gitStatus=$(color "$Status" 4)

Add="Stage changes (git add)"
gitAdd=$(color "$Add" 5)
Log="View commit log (git log)"
gitLog=$(color "$Log" 6)
Fetch="Compare local & remote repo (git fetch)"
gitFetch=$(color "$Fetch" 3)
Merge="Merge branches (git merge)"
gitMerge=$(color "$Merge" 4)
Branch="Create a new branch (git branch)"    
gitBranch=$(color "$Branch" 5)
Checkout="Switch to a branch (git checkout)"
gitCheckout=$(color "$Checkout" 1)
Finish="Finishing - Add, commit, and push"
gitFinish=$(color "$Finish" 2)

## =========== akhir colorized ============

while true; do
  
  echo -e "\nTarget yang Tersedia:"
  echo "  $(color 1 '7')  : $gitStatus"
  echo "  $(color 2 '2')  : $gitAdd"
  echo "  $(color 3 '3')  : $gitLog"
  echo "  $(color 4 '4')  : $gitFetch"
  echo "  $(color 5 '5')  : $gitMerge"
  echo "  $(color 6 '6')  : $gitBranch"
  echo "  $(color 7 '7')  : $gitCheckout"
  echo "  $(color 8 '8')  : $gitFinish"
  echo "  $(color 9 '9')  : Discard changes in working directory (git restore)"
  echo "  $(color 10 '10') : Create and apply patches (git diff and git apply)"
  echo "  $(color 11 '11') : Undo last commit (git reset)"
  echo "  $(color 0 '0')  : Exit"


    read -p "Masukkan nomor target: " choice

    case $choice in
        1) git status ;;
        2)
            echo -e "\nStaging changes..."
            git add .
            echo -e "Changes staged. Ready for commit.\n" ;;
        3) git log ;;
        4) git fetch ;;
        5) git merge ;;
        6) git branch ;;
        7) git checkout ;;
        8)
          git add .
          commit_with_dynamic_comment
          git push -u origin Master
            echo -e "\nFinishing - Add, commit, and push..."
            # Tambahkan perintah sesuai kebutuhan
            echo -e "Finishing complete.\n" ;;
        9) git restore ;;
       10)
            echo -e "\nCreating and applying patches..."
            # Tambahkan perintah sesuai kebutuhan
            echo -e "Patches applied.\n" ;;
       11) git reset ;;
        0)
            clear
            echo -e "Terima kasih! Program berakhir.\n"
            break ;;
        *) echo -e "Pilihan tidak valid. Silakan masukkan nomor yang benar.\n" ;;
    esac
done

