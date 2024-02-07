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
    "7") echo -e "\e[31;43m$text\e[0m" ;;  # Red with Yellow Background
    "8") echo -e "\e[1;34m$text\e[0m" ;;  # Light Blue
    "9") echo -e "\e[1;37m$text\e[0m" ;;  # Light White
    "10") echo -e "\e[1;30m$text\e[0m" ;;  # Light Grey
    "11") echo -e "\e[41m$text\e[0m" ;;   # Background Red
    "0") echo -e "\e[36m$text\e[0m" ;;   # Cyan
    *) echo "$text" ;;
  esac
}


while true; do
  echo -e "\nTarget yang Tersedia:"
  echo "  $(color 1 '7')  : $(color 'View status (git status)' 4)"
  echo "  $(color 2 '2')  : $(color 'Stage changes (git add)' 5)"
  echo "  $(color 3 '3')  : $(color 'View commit log (git log)' 6)"
  echo "  $(color 4 '4')  : $(color 'Compare local & remote repo (git fetch)' 3)"
  echo "  $(color 5 '5')  : $(color 'Merge branches (git merge)' 4)"
  echo "  $(color 6 '6')  : $(color 'Create a new branch (git branch)' 5)"
  echo "  $(color 7 '7')  : $(color 'Switch to a branch (git checkout)' 1)"
  echo "  $(color 8 '8')  : $(color 'Finishing - Add, commit, and push' 2)"
  echo "  $(color 9 '9')  : $(color 'Discard changes in working directory (git restore)' 4)"
  echo "  $(color 10 '10') : $(color 'Create and apply patches (git diff and git apply)' 3)"
  echo "  $(color 11 '11') : $(color 'Undo last commit (git reset)' 6)"
  echo "  $(color 0 '0')  : $(color 'Exit' 6)"

  read -p "Masukkan nomor target: " choice

  case $choice in
    1)
      clear
      echo
      git status ;;
    2)
      echo -e "\nStaging changes..."
      git add .
      echo -e "Changes staged. Ready for commit.\n" ;;
    3)
      clear &&
      git log --date=format:'%A %d %B %Y %H:%M:%S' --pretty=format:'%h %s';;
    4) git fetch ;;
    5) git merge ;;
    6) git branch ;;
    7) git checkout ;;
    8)
      git add .
      git push -u origin Master
      echo -e "\nFinishing - Add, commit, and push..."
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

