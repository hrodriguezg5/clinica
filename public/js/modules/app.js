
import { loadModule } from './moduleLoader.js';
import { apiService } from './apiService.js';

document.addEventListener('DOMContentLoaded', async () => {
    const path = window.location.pathname;
    const module = path.split('/').pop();
    await loadModule(module);
    const logoutLink = document.getElementById('logoutLink'); // Selecciona el enlace por su clase

    
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
