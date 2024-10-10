<<<<<<< HEAD
import { apiService } from '../services/apiService.js';
=======
import { apiService } from './apiService.js';
>>>>>>> 49730f1af6866bc5d1c47702f1907670c1e4ba08

export async function loadModule(module) {
    const url = `${urlBase}/${module}/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');

        if (data) {
            const hasAccess = data.modules.some(item => item.link === module);

            if (!hasAccess) {
                window.location.href = urlBase;
                return;
            }
            
            $('#spinner').removeClass('show');
            updateUserInfo(data);
            createMenu(data.modules, module, data);
        } else {
            window.location.href = urlBase;
        }
    } else {
        window.location.href = urlBase;
    }
}

// Función pura para actualizar la información del usuario
const updateUserInfo = (data) => {
    const navUserName = document.getElementById('navUserName');
    const navRoleName = document.getElementById('navRoleName');
    const dropUserName = document.getElementById('dropUserName');
    const greetingTitle = document.getElementById("greetingTitle");

    navUserName.textContent = data.user_name;
    dropUserName.textContent = data.user_name;
    navRoleName.innerText = data.role_name;

    if (greetingTitle) {
<<<<<<< HEAD
        greetingTitle.textContent = `¡Hola ${data.first_name}!`;
=======
        greetingTitle.textContent = `¡Hola ${data.user_name}!`;
>>>>>>> 49730f1af6866bc5d1c47702f1907670c1e4ba08
    }
};

// Función pura para crear el menú dinámico
const createMenu = (menuItems, activeModule, data) => {
    const navbarNav = document.querySelector('.navbar-modules');

    // Utilizamos una función pura para limpiar y generar el menú
    const newNavContent = menuItems.map(item => createMenuItem(item, activeModule, data));
    
    navbarNav.innerHTML = ''; // Limpiar el menú existente
    newNavContent.forEach(link => navbarNav.appendChild(link));
};

// Función pura para crear un elemento de menú
const createMenuItem = (item, activeModule, data) => {
    const link = document.createElement('a');
    link.href = `${urlBase}/${item.link}`;

    if (activeModule === item.link) {
        link.className = 'nav-item nav-link active';
        moduleTitle.textContent = item.module;
        moduleIcon.className = item.icon + ' me-2 fa-2x text-dark';
    } else {
        link.className = 'nav-item nav-link';
    }

    const icon = document.createElement('i');
    icon.className = item.icon;
    link.appendChild(icon);

    link.appendChild(document.createTextNode(item.module));

    // Detectar clic en el enlace de forma funcional
    link.addEventListener('click', async (e) => {
        e.preventDefault();
        history.pushState(null, '', `${urlBase}/${item.link}`);
        await loadModuleContent(item, data);
        updateActiveMenuItem(item.link);
    });

    return link;
};

// Función pura para cargar el contenido del módulo y actualizar el DOM
const loadModuleContent = async (item, data) => {
    const contentContainer = document.getElementById('content');
    const moduleContent = await fetchModuleContent(item.link);

    if (moduleContent) {
        contentContainer.classList.add('fade');
        contentContainer.classList.remove('show');

        setTimeout(() => {
            contentContainer.innerHTML = moduleContent.innerHTML;
            contentContainer.classList.add('show');

            // Actualizamos el título e ícono del módulo de forma pura
            updateModuleInfo(item, data);
        }, 250);
    }
};

// Función para actualizar el estado "activo" del menú
const updateActiveMenuItem = (activeLink) => {
    const navbarNav = document.querySelector('.navbar-modules');
    const links = navbarNav.querySelectorAll('a');

    links.forEach(link => {
        if (link.href.includes(activeLink)) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
};

// Función pura para actualizar el título y el ícono del módulo en el DOM
const updateModuleInfo = (item, data) => {
    const moduleTitle = document.getElementById('moduleTitle');
    const moduleIcon = document.getElementById('moduleIcon');

    moduleTitle.textContent = item.module;
    moduleIcon.className = `${item.icon} me-2 fa-2x text-dark`;

    updateUserInfo(data);
};

// Función pura para obtener el contenido del módulo
const fetchModuleContent = async (module) => {
    const response = await fetch(`${urlBase}/${module}`);
    if (response.ok) {
        const html = await response.text();

        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = html;
        return tempDiv.querySelector('#content');
    } else {
        console.error('Error al cargar el contenido del módulo');
        return null;
    }
};
