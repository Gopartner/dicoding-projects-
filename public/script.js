const jsonContainer = document.getElementById('json-container');

// Mengambil data dari URL
fetch('http://10.68.65.109:3000/books')
  .then(response => response.json())
  .then(data => {
    // Merender data dalam HTML dengan highlight kode
    data.forEach(item => {
      const div = document.createElement('div');
      div.classList.add('json-item');
      div.innerHTML = `<pre class="highlight-code">${JSON.stringify(item, null, 2)}</pre>`;
      jsonContainer.appendChild(div);
    });
  })
  .catch(error => console.error('Error fetching data:', error));

