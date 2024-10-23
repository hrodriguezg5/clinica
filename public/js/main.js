
import { loadModule } from './moduleLoader.js';
import { apiService } from './services/apiService.js';

document.addEventListener('DOMContentLoaded', async () => {
    const module = window.location.pathname.split('/').pop();
    await loadModule(module);
    
    document.getElementById('logoutLink').addEventListener('click', async (e) => {
        e.preventDefault();
        const url = `${urlBase}/login/salir`;
        const token = localStorage.getItem('token');
        
        try {
            const response = await apiService.fetchData(url, 'POST', { token });
            if (response.success) {
                localStorage.removeItem('token');
                window.location.href = urlBase;
            } else {
                window.location.href = urlBase;
            }
        } catch (error) {
            window.location.href = urlBase;
        }
    });

    const insertModal = document.getElementById('insertModal');
    const insertForm = document.getElementById('insertForm');

    // Evento que se dispara al cerrar el modal
    insertModal.addEventListener('hidden.bs.modal', function () {
        // Restablecer el formulario para evitar el guardado de contraseñas
        insertForm.reset();
    });
});
