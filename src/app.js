// src/app.js
const express = require('express');
const bodyParser = require('body-parser');
const os = require('os');
const networkInterfaces = os.networkInterfaces();
const path = require('path');
const yargs = require('yargs');
const nodemon = require('nodemon');
const morgan = require('morgan');

const BookService = require('./services/BookService');
const BookController = require('./controllers/BookController');

// Inisialisasi Express
const app = express();
const PORT = 8000;

// Middleware untuk parsing JSON
app.use(bodyParser.json());

// Gunakan morgan untuk pencatatan permintaan HTTP
app.use(morgan('dev'));

// Path untuk data buku
const dataPath = path.join(__dirname, '..', 'data', 'books.json');
const bookService = new BookService(dataPath);
const bookController = new BookController(bookService);

// Route untuk halaman default
app.get('/', (req, res) => {
  const indexPath = path.join(__dirname, 'views', 'index.html');
  res.sendFile(indexPath);
});

// Rute untuk mendapatkan daftar buku
app.get('/books', (req, res) => {
  const books = bookController.getAllBooks();
  res.json(books);
});


// Rute untuk mendapatkan detail buku berdasarkan ID
app.get('/books/:id', (req, res) => {
  const bookId = parseInt(req.params.id);
  const book = bookController.getBookById(bookId);

  if (book) {
    res.json(book);
  } else {
    res.status(404).json({ message: 'Book not found' });
  }
});

// Rute untuk menambahkan buku baru
app.post('/books', (req, res) => {
  const newBook = req.body;
  const book = bookController.addBook(newBook);
  res.status(201).json(book);
});

// Rute untuk mengupdate buku berdasarkan ID
app.put('/books/:id', (req, res) => {
  const bookId = parseInt(req.params.id);
  const updatedBook = req.body;
  const book = bookController.updateBook(bookId, updatedBook);

  if (book) {
    res.json(book);
  } else {
    res.status(404).json({ message: 'Book not found' });
  }
});

// Rute untuk menghapus buku berdasarkan ID
app.delete('/books/:id', (req, res) => {
  const bookId = parseInt(req.params.id);
  bookController.deleteBook(bookId);
  res.status(204).send();
});

// ... (kode setelahnya)


// Menjalankan server
app.listen(PORT, () => {
  // Mendapatkan alamat IP dari antarmuka yang terhubung ke jaringan
  const ipAddress = Object.values(networkInterfaces)
    .flat()
    .filter((iface) => iface.family === 'IPv4' && !iface.internal)[0].address;

  console.log(`Server is running on http://${ipAddress}:${PORT}`);
  console.log(`You can access the app locally at http://${ipAddress}:${PORT}/books`);
});

// Export aplikasi untuk pengujian
module.exports = app;

// Jika aplikasi dijalankan dengan skrip "npm run dev"
if (yargs.argv._.includes('dev')) {
  // Menggunakan nodemon untuk mendeteksi perubahan dan melakukan reload
  nodemon({
    script: 'index.js',  // File utama aplikasi
    ext: 'js json',      // Ekstensi yang dimonitor
    watch: ['src'],      // Direktori yang dimonitor
    ignore: ['data'],    // Direktori yang diabaikan
    env: {
      HOST: yargs.argv.host || 'localhost',  // Mengambil nilai host dari argumen atau default 'localhost'
      PORT: PORT.toString(),
    },
  });
}

