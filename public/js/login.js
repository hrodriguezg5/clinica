import { apiService } from './services/apiService.js';
import { isEmpty } from './utils/validation.js';
import { showAlert } from './utils/showArlert.js';

let tokenData;

// Inicializar la página
document.addEventListener("DOMContentLoaded", async function() {
    const url = `${urlBase}/login/token`;
    const token = localStorage.getItem('token');
    const tokenExpired = localStorage.getItem('tokenExpired');

    if (tokenExpired === 'true') {
        showAlert('Token Expirado. Por favor, inicia sesión de nuevo.', 'danger');
        localStorage.removeItem('tokenExpired');
    }

    if (token) {
        try {
            const data = await apiService.fetchData(url, 'GET');
            tokenData = data;

            if (data) {
                if (data.modules[0]) {
                    window.location.href = `${urlBase}/${data.modules[0].link}`;
                } else {
                    localStorage.removeItem('token');
                    showAlert('El usuario no tiene módulos asignados.', 'warning');
                    $('#spinner').removeClass('show');
                }
            } else {
                localStorage.removeItem('token');
                $('#spinner').removeClass('show');
            }
        } catch (error) {
            showAlert('Error de conexión, por favor intenta de nuevo.', 'danger');
        }
    } else {
        $('#spinner').removeClass('show');
    }

});

// Alternar visibilidad de contraseña
document.getElementById("togglePassword").addEventListener("click", function () {
    const passwordField = document.querySelector("#loginPassword");
    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
    passwordField.setAttribute("type", type);
    this.querySelector('i').classList.toggle("bi-eye");
    this.querySelector('i').classList.toggle("bi-eye-slash");
});

// Enviar formulario de inicio de sesión
document.getElementById('loginForm').onsubmit = async function (e) {
    e.preventDefault();

    const usernameInput = document.getElementById('loginUsername');
    const passwordInput = document.getElementById('loginPassword');
    const username = usernameInput.value;
    const password = passwordInput.value;
    const url = `${urlBase}/login/ingresar`;

    if (isEmpty(username)) {
        showAlert('El campo de usuario es obligatorio', 'danger');
        usernameInput.classList.add('input-error');
        passwordInput.classList.remove('input-error');
        return;
    } else {
        usernameInput.classList.remove('input-error');
    }

    if (isEmpty(password)) {
        showAlert('El campo de contraseña es obligatorio', 'danger');
        passwordInput.classList.add('input-error');
        usernameInput.classList.remove('input-error');
        return;
    } else {
        passwordInput.classList.remove('input-error');
    }

    try {
        const data = await apiService.fetchData(url, 'POST', { username, password });

        if (data.success) {
            localStorage.setItem('token', data.token);

            // Usar el Credential Management API para almacenar las credenciales
            if ('credentials' in navigator) {
                const credentials = new PasswordCredential({
                    id: username,
                    password: password,
                    name: username
                });

                // Almacenar las credenciales en el navegador
                await navigator.credentials.store(credentials);
            }

            try {
                const url = `${urlBase}/login/token`;
                const data = await apiService.fetchData(url, 'GET');
    
                if (data && data.modules[0]) {
                    window.location.href = `${urlBase}/${data.modules[0].link}`;
                } else {
                    localStorage.removeItem('token');
                    showAlert('El usuario no tiene módulos asignados.', 'warning');
                }
            } catch (error) {
                showAlert('Error de conexión, por favor intenta de nuevo.', 'danger');
            }
        } else {
            showAlert(data.message, 'danger');
        }
    } catch (error) {
        showAlert('Error de conexión, por favor intenta de nuevo.', 'danger');
    }
};
