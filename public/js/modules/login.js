import { apiService } from './apiService.js';
import { showAlert } from './showArlert.js';

document.addEventListener("DOMContentLoaded", async function() {
    const url = `${urlBase}/login/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');

        if (data){
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

    const url = `${urlBase}/login/ingresar`;
    const data = await apiService.fetchData(url, 'POST', { username, password });
    
    if (data.success) {
        localStorage.setItem('token', data.token);
        window.location.href = urlBase;
    } else {
        showAlert(data.message);
    }
};
