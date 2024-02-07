<!-- main.js -->
<div class="main" id="mainContent">
  <!-- Konten utama akan ditampilkan di sini -->
</div>

<script>
  async function showMain(page) {
    const mainContent = document.getElementById('mainContent');
    const pageTitle = document.getElementById('pageTitle');
    
    if (page === 'Home') {
      mainContent.innerHTML = '<p>Welcome to the Home Page!</p>';
    } else if (page === 'Books') {
      try {
        const response = await fetch('http://10.252.66.154:3000/books');
        const books = await response.json();
        
        mainContent.innerHTML = '<h2>List of Books</h2>';
        books.forEach(book => {
          mainContent.innerHTML += `<div class="highlight-code">${JSON.stringify(book)}</div>`;
        });
      } catch (error) {
        console.error('Error fetching data:', error);
        mainContent.innerHTML = '<p>Error fetching data</p>';
      }
    }
    
    pageTitle.innerText = page;
  }
</script>

