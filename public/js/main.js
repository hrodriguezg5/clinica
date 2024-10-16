
import { loadModule } from './moduleLoader.js';
import { apiService } from './services/apiService.js';

document.addEventListener('DOMContentLoaded', async () => {
    const module = window.location.pathname.split('/').pop();
    await loadModule(module);
    
    document.getElementById('logoutLink').addEventListener('click', async (e) => {
        e.preventDefault();
        const url = `${urlBase}/login/salir`;
        const token = localStorage.getItem('token');
        if (token) {
            const response = await apiService.fetchData(url, 'POST', { token });
            
            if (response.success) {
                localStorage.removeItem('token');
                window.location.href = urlBase;
            } else {
                console.error(response.message);
            }
        } else {
            window.location.href = urlBase;
        }
    });
});
