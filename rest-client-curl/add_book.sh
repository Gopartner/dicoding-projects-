#!/bin/bash

read -p "Masukkan judul buku: " title
read -p "Masukkan nama penulis: " author

curl -X POST -H "Content-Type: application/json" -d "{\"title\":\"$title\",\"author\":\"$author\"}" http://localhost:3000/books

