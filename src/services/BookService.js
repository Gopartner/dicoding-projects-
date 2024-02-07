// src/services/BookService.js
const fs = require('fs');
const path = require('path');

class BookService {
  constructor(dataPath) {
    this.dataPath = dataPath;
  }

  getAllBooks() {
    const data = this.readData();
    return data.books;
  }

  getBookById(bookId) {
    const data = this.readData();
    return data.books.find(book => book.id === bookId);
  }

  addBook(book) {
    const data = this.readData();
    book.id = this.generateId();
    data.books.push(book);
    this.saveData(data);
    return book;
  }

  updateBook(bookId, updatedBook) {
    const data = this.readData();
    const index = data.books.findIndex(book => book.id === bookId);

    if (index !== -1) {
      data.books[index] = { ...data.books[index], ...updatedBook };
      this.saveData(data);
      return data.books[index];
    }

    return null;
  }

  deleteBook(bookId) {
    const data = this.readData();
    data.books = data.books.filter(book => book.id !== bookId);
    this.saveData(data);
  }

  readData() {
    const dataBuffer = fs.readFileSync(this.dataPath);
    const dataJSON = dataBuffer.toString();
    return JSON.parse(dataJSON);
  }

  saveData(data) {
    const dataJSON = JSON.stringify(data, null, 2);
    fs.writeFileSync(this.dataPath, dataJSON);
  }

  generateId() {
    const data = this.readData();
    const lastId = data.books.length > 0 ? data.books[data.books.length - 1].id : 0;
    return lastId + 1;
  }
}

module.exports = BookService;

