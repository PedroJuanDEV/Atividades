document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('searchInput');
    const resultsContainer = document.getElementById('results-container');
    const loadingIndicator = document.getElementById('loading');
    const errorMessage = document.getElementById('error-message');
    const bookModal = document.getElementById('book-modal');
    const closeModalBtn = document.getElementById('close-modal-btn');
    const modalContent = document.getElementById('modal-content');
    
    const API_URL = 'https://www.googleapis.com/books/v1/volumes';
    const TIMEOUT_MS = 5000;

    async function searchBooks(query) {
        if (!query) return;

        const controller = new AbortController();
        const signal = controller.signal;
        const timeoutId = setTimeout(() => controller.abort(), TIMEOUT_MS);

        try {
            loadingIndicator.classList.remove('hidden');
            errorMessage.classList.add('hidden');
            resultsContainer.innerHTML = '';

            const response = await fetch(`${API_URL}?q=${encodeURIComponent(query)}&maxResults=15`, { signal });
            
            if (!response.ok) {
                throw new Error(`Erro na rede: ${response.status}`);
            }

            const data = await response.json();
            
            renderBooks(data.items);

        } catch (error) {
            if (error.name === 'AbortError') {
                errorMessage.textContent = 'A busca demorou demais. Por favor, verifique sua conexão ou tente novamente.';
            } else {
                errorMessage.textContent = 'Houve um erro ao buscar os livros. Tente novamente.';
            }
            errorMessage.classList.remove('hidden');
        } finally {
            loadingIndicator.classList.add('hidden');
            clearTimeout(timeoutId);
        }
    }

    function renderBooks(books) {
        if (!books || books.length === 0) {
            resultsContainer.innerHTML = '<p class="text-gray-500 text-center col-span-full">Nenhum livro encontrado.</p>';
            return;
        }

        books.forEach(book => {
            const volumeInfo = book.volumeInfo;
            const title = volumeInfo.title || 'Título indisponível';
            const authors = volumeInfo.authors ? volumeInfo.authors.join(', ') : 'Autor(es) indisponível(eis)';
            const image = volumeInfo.imageLinks?.thumbnail || 'https://placehold.co/128x193/e5e7eb/6b7280?text=Sem+Capa';

            const bookCard = document.createElement('div');
            bookCard.className = 'bg-gray-100 p-4 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-300 cursor-pointer text-left';
            
            const imageEl = document.createElement('img');
            imageEl.src = image;
            imageEl.alt = `Capa do livro ${title}`;
            imageEl.className = 'w-24 h-auto mx-auto mb-4 rounded-md shadow-md';

            const titleEl = document.createElement('h2');
            titleEl.className = 'text-base font-semibold text-gray-800 line-clamp-2';
            titleEl.textContent = title;

            const authorsEl = document.createElement('p');
            authorsEl.className = 'text-xs text-gray-500 mt-1 line-clamp-1';
            authorsEl.textContent = authors;

            bookCard.appendChild(imageEl);
            bookCard.appendChild(titleEl);
            bookCard.appendChild(authorsEl);
            
            bookCard.addEventListener('click', () => showBookDetails(volumeInfo));
            
            resultsContainer.appendChild(bookCard);
        });
    }

    function showBookDetails(volumeInfo) {
        const title = volumeInfo.title || 'Título indisponível';
        const authors = volumeInfo.authors ? volumeInfo.authors.join(', ') : 'Autor(es) indisponível(eis)';
        const image = volumeInfo.imageLinks?.thumbnail || 'https://placehold.co/128x193/e5e7eb/6b7280?text=Sem+Capa';
        const description = volumeInfo.description || 'Nenhum resumo disponível.';
        const publishedDate = volumeInfo.publishedDate || 'Data de lançamento indisponível';
        
        modalContent.innerHTML = `
            <div class="flex flex-col md:flex-row items-center md:items-start gap-6">
                <img src="${image}" alt="Capa do livro ${title}" class="w-28 h-auto rounded-lg shadow-lg">
                <div class="text-left">
                    <h3 class="text-xl font-bold mb-2">${title}</h3>
                    <p class="text-sm text-gray-600 mb-1"><strong>Autor(es):</strong> ${authors}</p>
                    <p class="text-sm text-gray-600 mb-4"><strong>Lançamento:</strong> ${publishedDate}</p>
                    <p class="text-sm text-gray-700">${description}</p>
                </div>
            </div>
        `;
        bookModal.classList.remove('hidden');
    }

    closeModalBtn.addEventListener('click', () => {
        bookModal.classList.add('hidden');
    });

    searchInput.addEventListener('input', (event) => {
        searchBooks(event.target.value);
    });

    searchBooks('Programação');
});
