// Alternar visibilidad de contraseña
const togglePassword = document.querySelector("#togglePassword");
const passwordField = document.querySelector("#floatingPassword");

togglePassword.addEventListener("click", function () {
    // Alternar el atributo de tipo
    const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
    passwordField.setAttribute("type", type);

    // Alternar el icono
    this.querySelector('i').classList.toggle("bi-eye");
    this.querySelector('i').classList.toggle("bi-eye-slash");
});