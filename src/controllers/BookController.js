// src/controllers/BookController.js
class BookController {
  constructor(bookService) {
    this.bookService = bookService;
  }

  getAllBooks() {
    return this.bookService.getAllBooks();
  }

  getBookById(bookId) {
    return this.bookService.getBookById(bookId);
  }

  addBook(book) {
    return this.bookService.addBook(book);
  }

  updateBook(bookId, updatedBook) {
    return this.bookService.updateBook(bookId, updatedBook);
  }

  deleteBook(bookId) {
    return this.bookService.deleteBook(bookId);
  }
}

module.exports = BookController;

