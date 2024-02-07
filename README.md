# CRUD APP

## Fitur Aplikasi
1. **Mengelola Daftar Buku:** Aplikasi ini memungkinkan pengguna untuk melihat, menambah, mengupdate, dan menghapus buku dari daftar.
2. **Pemantauan Perubahan Otomatis:** Menggunakan `nodemon` untuk memantau perubahan dan melakukan reload otomatis saat mengembangkan aplikasi (`npm run dev`).
3. **Dukungan Pengaturan Host Dinamis:** Menyediakan opsi `--host` saat menjalankan aplikasi (`npm run dev` atau `npm start`).
4. **Menampilkan Informasi Server:** Menampilkan informasi server, termasuk alamat IP dan port saat aplikasi dijalankan.

## Teknologi Aplikasi
1. **Node.js dan Express:** Backend server menggunakan Node.js dengan framework Express.
2. **JSON sebagai Database:** Data buku disimpan dalam format JSON pada file `books.json`.
3. **Express Middleware:** Menerapkan middleware seperti `body-parser` untuk parsing data JSON.
4. **Yargs dan Nodemon:** Menggunakan `yargs` untuk mengelola argumen baris perintah dan `nodemon` untuk memantau perubahan selama pengembangan.

## Endpoint REST API
1. **GET /books:** Mendapatkan daftar semua buku.
   - Endpoint URL:
    ```bash
     http://localhost:3000/books
    ```
   - Contoh Penggunaan dengan Curl
     ```bash
     curl http://localhost:3000/books
     ```

2. **GET /books/:id:** Mendapatkan detail buku berdasarkan ID.
   - Endpoint URL:
     ```bash
     http://localhost:3000/books/:id
     ```
   - Contoh Penggunaan Curl:
     ```bash
     curl http://localhost:3000/books/1
     ```

3. **POST /books:** Menambahkan buku baru.
   - Endpoint URL:
      ```bash
     `http://localhost:3000/books`
      ```
   - Contoh Penggunaan Curl:
     ```bash
     curl -X POST -H "Content-Type: application/json" -d '{"title":"New Book","author":"New Author"}' http://localhost:3000/books
     ```

4. **PUT /books/:id:** Mengupdate buku berdasarkan ID.
   - Endpoint URL:
   - ```bash
     http://localhost:3000/books/:id
     ```
   - Contoh Penggunaan Curl:
     ```bash
     curl -X PUT -H "Content-Type: application/json" -d '{"title":"Updated Book","author":"Updated Author"}' http://localhost:3000/books/1
     ```

5. **DELETE /books/:id:**
  *Menghapus buku berdasarkan ID.*
   - Endpoint URL:
   - ```bash
   http://localhost:3000/books/:id
   ```
   - Contoh Penggunaan Curl:
   - ```bash
   curl -X DELETE http://localhost:3000/books/1
   ```

1. **Clone Repository:**
- clone
```cmd
https://github.com/Gopartner/crud-javascript.git
```

2. **Instalasi Dependensi:**
   ```bash
   npm install
   ```
   **Tool bash ada di folder gitbash-app
   ##jalanka npm run mygit untuk ginakan tool
   ```bash
   npm run mygit
   ```
