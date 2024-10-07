import { apiService } from './apiService.js';

document.addEventListener('DOMContentLoaded', async () => {
    const token = localStorage.getItem('token');

    if (!token) {
        window.location.href = urlBase;
        return;
    }

    try {
        const url = `${urlBase}/paciente/token`;
        const data = await apiService.fetchData(url, 'GET');
        
        if (data) {
            $('#spinner').removeClass('show');
            const naveUserName = document.getElementById('naveUserName');
            const navRoleName = document.getElementById('navRoleName');
            const dropUserName = document.getElementById('dropUserName');

            naveUserName.textContent = data.user_name;
            dropUserName.textContent = data.user_name;
            navRoleName.innerText = data.role_name;
            
            // Supongamos que 'data.menuItems' es un arreglo con los elementos del menú
            const menuItems = data.modules;

            // Selecciona el <div class="navbar-nav w-100">
            const navbarNav = document.querySelector('.navbar-modules');

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
            window.location.href = `${urlBase}`;
        }
    } catch (error) {
        console.error('Error:', error);
        window.location.href = `${urlBase}`;
    }
});
