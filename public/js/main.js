
import { loadModule } from './modules/moduleLoader.js';
import { apiService } from './services/apiService.js';

document.addEventListener('DOMContentLoaded', async () => {
    const module = window.location.pathname.split('/').pop();
    await loadModule(module);
    const logoutLink = document.getElementById('logoutLink');
    
    logoutLink.addEventListener('click', async (e) => {
        e.preventDefault(); // Prevenir el comportamiento por defecto del enlace
        const url = `${urlBase}/login/salir`;
        const token = localStorage.getItem('token');
        if (token) {
            const response = await apiService.fetchData(url, 'POST', { token });
            
            if (response.success) {
                localStorage.removeItem('token');
                window.location.href = urlBase; // Redirigir al login
            } else {
                console.error(response.message);
            }
        }
    });
});
