






// scroll body
window.addEventListener('scroll', () => {
  const navbar = document.getElementById('navbar');
  const scrollY = window.scrollY;

  if (scrollY > 100) {
    navbar.classList.add('top');
  } else {
    navbar.classList.remove('top');
  }
});


// Carousel
const track = document.getElementById('track');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

let currentIndex = 0;

function updateCarousel() {
  const slideWidth = track.clientWidth / 2;
  track.style.transform = `translateX(-${slideWidth * currentIndex}px)`;
}

prevBtn?.addEventListener('click', () => {
  currentIndex = (currentIndex - 1 + 2) % 2;
  updateCarousel();
});

nextBtn?.addEventListener('click', () => {
  currentIndex = (currentIndex + 1) % 2;
  updateCarousel();
});


// cards

document.querySelectorAll('.card').forEach(card => {
  card.addEventListener('click', () => {
    alert('Você clicou no card: ' + card.querySelector('.card-text').textContent);
  });
});


document.addEventListener('DOMContentLoaded', () => {
    // Seleciona todos os cards
    const cards = document.querySelectorAll('.card');
    const modal = document.getElementById('projectModal');
    const closeButton = document.querySelector('.close-button');

    // Elementos do modal para preencher
    const modalTitle = document.getElementById('modalTitle');
    const modalImage = document.getElementById('modalImage');
    const modalDescription = document.getElementById('modalDescription');
    const modalLink = document.getElementById('modalLink');

    // Função para abrir o modal
    function openModal(card) {
        // Preenche o modal com os dados do card clicado
        modalTitle.textContent = card.dataset.title;
        modalImage.src = card.dataset.image;
        modalImage.alt = card.dataset.title; // Boa prática de acessibilidade
        modalDescription.textContent = card.dataset.description;
        modalLink.href = card.dataset.link;

        modal.style.display = 'flex'; // Exibe o modal (com flex para centralizar)
        document.body.style.overflow = 'hidden'; // Evita scroll da página principal
    }

    // Função para fechar o modal
    function closeModal() {
        modal.style.display = 'none'; // Esconde o modal
        document.body.style.overflow = ''; // Restaura scroll da página
    }

    // Adiciona evento de clique a cada card
    cards.forEach(card => {
        card.addEventListener('click', () => {
            openModal(card);
        });
    });

    // Adiciona evento de clique ao botão de fechar
    closeButton.addEventListener('click', closeModal);

    // Fecha o modal se clicar fora do conteúdo (no overlay)
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            closeModal();
        }
    });

    // Fecha o modal ao pressionar a tecla ESC
    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape' && modal.style.display === 'flex') {
            closeModal();
        }
    });

    // ... (parte superior do seu JS) ...

// Função para abrir o modal
function openModal(card) {
    // Preenche o modal com os dados do card clicado
    modalTitle.textContent = card.dataset.title;
    modalImage.src = card.dataset.image;
    modalImage.alt = card.dataset.title;
    modalDescription.textContent = card.dataset.description;
    modalLink.href = card.dataset.link;
    // Adicionei essa linha para esconder/mostrar o link dependendo do data-link
    modalLink.style.display = (card.dataset.link && card.dataset.link !== '#') ? 'inline-block' : 'none'; 

    // Esta linha torna o modal visível e o centraliza
    modal.style.display = 'flex'; 
    document.body.style.overflow = 'hidden'; // Evita scroll da página principal
}

// ... (o restante do seu JS, que você já compartilhou e está correto) ...
});