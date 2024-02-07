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
spinner "Spinner Baru"

