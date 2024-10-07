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
    const errorMessage = document.getElementById('errorMessage');

    const response = await fetch('http://localhost/clinica/login/ingresar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password })
    });

    if (response.ok) {
        const data = await response.json();
        if (data.success) {
            localStorage.setItem('token', data.token); // Guardar token en localStorage
            window.location.href = 'http://localhost/clinica/paciente'; // Redirigir al dashboard
        } else {
            errorMessage.textContent = data.message;
        }
    } else {
        const error = await response.json();
        alert(error.message);
    }
};