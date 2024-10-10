<<<<<<< HEAD
import { apiService } from '../services/apiService.js';
import { showAlert } from '../utils/showArlert.js';
=======
import { apiService } from './apiService.js';
import { showAlert } from './showArlert.js';
>>>>>>> 49730f1af6866bc5d1c47702f1907670c1e4ba08

document.addEventListener("DOMContentLoaded", async function() {
    const url = `${urlBase}/login/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');

<<<<<<< HEAD
        if (data) {
=======
        if (data){
>>>>>>> 49730f1af6866bc5d1c47702f1907670c1e4ba08
            if (data.modules[0]) {
                window.location.href = `${urlBase}/${data.modules[0].link}`;
            } else {
                localStorage.removeItem('token');
                showAlert('El usuario no tiene módulos asignados.');
                $('#spinner').removeClass('show');
            }
        } else {
            localStorage.removeItem('token');
            showAlert('Token Expirado.');
            $('#spinner').removeClass('show');
        }
    } else {
        $('#spinner').removeClass('show');
    }

});

// Alternar visibilidad de contraseña
const togglePassword = document.querySelector("#togglePassword");
const passwordField = document.querySelector("#loginPassword");

togglePassword.addEventListener("click", function () {
    // Alternar el atributo de tipo
    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
    passwordField.setAttribute("type", type);

    // Alternar el icono
    this.querySelector('i').classList.toggle("bi-eye");
    this.querySelector('i').classList.toggle("bi-eye-slash");
});

document.getElementById('loginForm').onsubmit = async function (e) {
    e.preventDefault();
    const username = document.getElementById('loginUsername').value;
    const password = document.getElementById('loginPassword').value;
<<<<<<< HEAD
    const url = `${urlBase}/login/ingresar`;

    try {
        const data = await apiService.fetchData(url, 'POST', { username, password });
        if (data.success) {
            localStorage.setItem('token', data.token);
            window.location.href = urlBase;
        } else {
            showAlert(data.message);
        }
    } catch (error) {
        showAlert('Error de conexión, por favor intenta de nuevo.');
    }
    
=======

    const url = `${urlBase}/login/ingresar`;
    const data = await apiService.fetchData(url, 'POST', { username, password });
    
    if (data.success) {
        localStorage.setItem('token', data.token);
        window.location.href = urlBase;
    } else {
        showAlert(data.message);
    }
>>>>>>> 49730f1af6866bc5d1c47702f1907670c1e4ba08
};
