// URL de la API y clave API
const API_URL = 'http://localhost/clinica/medicina/mostrar';
const API_KEY = '22535582'; // Reemplaza con tu API Key

// Constante para almacenar productos
let products = [];

// Función para cargar productos desde la API
async function loadProducts() {
    try {
        const response = await fetch(API_URL, {
            method: 'GET',
            headers: {
                'X-Api-Key': API_KEY // Usa la API Key en el encabezado
            }
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        products = data.map(item => ({
            name: item.name,
            description: item.description,
            price: `$${item.selling_price}`,
            imageUrl: `http://localhost/clinica/${item.image_path}`
        }));

        displayProducts(); // Llama a la función para mostrar productos en la página
    } catch (error) {
        console.error('Error al cargar productos:', error);
    }
}

// Función para mostrar productos en tarjetas
function displayProducts() {
    const productContainer = document.querySelector('.container .row');
    productContainer.innerHTML = ''; // Limpia el contenido existente

    products.forEach((product, index) => {
        // Crea el HTML de cada tarjeta
        const productCard = `
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}" onclick="showProductModal(${index})" style="cursor:pointer;">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <button type="button" class="btn btn-primary" onclick="showProductModal(${index})">Ver Detalle</button>
                    </div>
                </div>
            </div>
        `;

        productContainer.insertAdjacentHTML('beforeend', productCard);
    });
}

// Función para mostrar el modal con los detalles del producto
function showProductModal(index) {
    const product = products[index];
    document.getElementById("productName").textContent = product.name;
    document.getElementById("productDescription").textContent = product.description;
    document.getElementById("productPrice").textContent = product.price;
    document.getElementById("productImage").src = product.imageUrl;

    // Abrir el modal
    const modal = new bootstrap.Modal(document.getElementById('productModal'));
    modal.show();
}

function filterProducts(){
    const searchInput = document.getElementById('searchInput').value.toLowerCase();
    const filterProducts = products.filter(product =>
        product.name.toLowerCase().includes(searchInput)
    );

    displayFilteredProducts(filterProducts);

}

function displayFilteredProducts(filterProducts) {
    const productContainer = document.querySelector('.container .row');
    productContainer.innerHTML = '';

    filterProducts.forEach((product, index) => {
        
        const productCard = `
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}" onclick="showProductModal(${index})" style="cursor:pointer;">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <button type="button" class="btn btn-primary" onclick="showProductModal(${index})">Ver Detalle</button>
                    </div>
                </div>
            </div>
        `;

        productContainer.insertAdjacentHTML('beforeend', productCard);
    });
}

// Llama a la función para cargar productos al cargar la página
loadProducts();

//activa el evento del filtro
document.getElementById('searchInput').addEventListener('input', filterProducts);
