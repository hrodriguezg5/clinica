async function checkTokenAndLoadDashboard() {
    const token = localStorage.getItem('token');

    // Si no hay token, redirige al login
    if (!token) {
        window.location.href = 'http://localhost/clinica';
        return;
    }

    // Llamada al API del dashboard
    const response = await fetch('http://localhost/clinica/paciente/token', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}` // Envía el token en el encabezado
        }
    });
    
    // Verifica la respuesta del servidor
    if (response.ok) {
        const data = await response.json();
        const naveUserName = document.getElementById('naveUserName');
        const navRoleName = document.getElementById('navRoleName');
        const dropUserName = document.getElementById('dropUserName');
        
        naveUserName.textContent = data.user_name;
        dropUserName.textContent = data.user_name;
        navRoleName.innerText = data.role_name;
        $('#spinner').removeClass('show');

        // Supongamos que 'data.menuItems' es un arreglo con los elementos del menú
        const menuItems = data.modules;

        // Selecciona el <div class="navbar-nav w-100">
        const navbarNav = document.querySelector('.navbar-nav.w-100');

        // Limpia cualquier contenido existente
        navbarNav.innerHTML = '';

        // Itera sobre los elementos del menú y crea los <a>
        menuItems.forEach(item => {
            // Crea el elemento <a>
            const link = document.createElement('a');
            link.href = `${urlBase}/${item.link}`;
            link.className = 'nav-item nav-link';

            // Crea el elemento <i> para el icono
            const icon = document.createElement('i');
            icon.className = item.icon;

            // Añade el icono al enlace
            link.appendChild(icon);

            // Añade el nombre del elemento del menú
            link.appendChild(document.createTextNode(item.module));

            // Añade el enlace al <div>
            navbarNav.appendChild(link);
        });

    } else {
        // Si el token es inválido o ha expirado, redirige al login
        window.location.href = 'http://localhost/clinica';
    }
}

// Ejecuta la función al cargar la página
document.addEventListener('DOMContentLoaded', checkTokenAndLoadDashboard);
