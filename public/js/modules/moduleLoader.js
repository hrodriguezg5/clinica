import { apiService } from './apiService.js';

export async function loadModule(module) {
    const url = `${urlBase}/${module}/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');
        
        if (data) {
            $('#spinner').removeClass('show');
            // Verificar si el usuario tiene permiso para acceder al módulo actual
            
            const hasAccess = data.modules.some(item => item.link === module);
            
            if (!hasAccess) {
                window.location.href = urlBase;
                return;
            }

            // Actualizar la información del usuario en el DOM
            const navUserName = document.getElementById('navUserName');
            const navRoleName = document.getElementById('navRoleName');
            const dropUserName = document.getElementById('dropUserName');
            const moduleTitle = document.getElementById('moduleTitle');
            const moduleIcon = document.getElementById('moduleIcon');
            const greetingTitle = document.getElementById("greetingTitle");

            navUserName.textContent = data.user_name;
            dropUserName.textContent = data.user_name;
            navRoleName.innerText = data.role_name;
            
            // Crear el menú dinámico
            const menuItems = data.modules;
            const navbarNav = document.querySelector('.navbar-modules');
            navbarNav.innerHTML = '';

            menuItems.forEach(item => {
                const link = document.createElement('a');
                link.href = `${urlBase}/${item.link}`;

                // Activar módulo ingresado
                if (module === item.link) {
                    link.className = 'nav-item nav-link active';
                    moduleTitle.textContent = item.module;
                    moduleIcon.className = item.icon + ' me-2 fa-2x text-dark';
                    
                    if (greetingTitle) {
                        greetingTitle.textContent = "¡Hola " + data.user_name + "!";
                    }
                } else {
                    link.className = 'nav-item nav-link';
                }

                const icon = document.createElement('i');
                icon.className = item.icon;
                link.appendChild(icon);

                link.appendChild(document.createTextNode(item.module));
                navbarNav.appendChild(link);
            });
        } else {
            window.location.href = urlBase;
        }
    } else {
        window.location.href = urlBase;
    }
}
