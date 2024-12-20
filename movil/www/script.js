// URL de la API y clave API
//const API_URL = 'http://192.168.1.3/clinica/medicina/mostrar';
const API_URL = 'https://clinicagt.shop/medicina/mostrar';
const API_KEY = 'Asfasd80L.$$12'; // Reemplaza con tu API Key
//const API_KEY = '22535582'; // Reemplaza con tu API Key

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
            price: `Q${item.selling_price}`,
            brand: item.brand,
            quantity: item.quantity,
            imageUrl: `https://clinicagt.shop/${item.image_path}`
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

        const availabilityBadge = product.quantity > 0
            ? `<span class="badge available">Disponible</span>`
            : `<span class="badge out-of-stock">Agotado</span>`;

        const productCard = `
            <div class="col-md-4 mb-4">
                <div class="card position-relative">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}" onclick="showProductModal(${index})" style="cursor:pointer;">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        ${availabilityBadge}
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
    document.getElementById("productDescription").textContent = `Descripción: ${product.description}`;
    document.getElementById("productPrice").textContent = `Precio ${product.price}`;
    document.getElementById("productBrand").textContent = `Marca: ${product.brand}`;
    document.getElementById("productQuantity").textContent = `Stock: ${product.quantity}`;
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
        const availabilityBadge = product.quantity > 0
            ? `<span class="badge available">Disponible</span>`
            : `<span class="badge out-of-stock">Agotado</span>`;
        
        const productCard = `
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}" onclick="showProductModal(${index})" style="cursor:pointer;">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        ${availabilityBadge}
                        <button type="button" class="btn btn-primary" onclick="showProductModal(${products.indexOf(product)})">Ver Detalle</button>
                    </div>
                </div>
            </div>
        `;

        productContainer.insertAdjacentHTML('beforeend', productCard);
    });
}

// Añadir evento para el botón de recarga
document.getElementById('reloadButton').addEventListener('click', function() {
    location.reload(); // Recarga la página
});


// Llama a la función para cargar productos al cargar la página
loadProducts();

//activa el evento del filtro
document.getElementById('searchInput').addEventListener('input', filterProducts);
