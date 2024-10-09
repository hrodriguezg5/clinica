export function showAlert(message) {
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const closeButton = document.getElementById('closeButton');

    // Restablecer la alerta si fue cerrada manualmente
    errorMessage.classList.remove("fade");
    errorMessage.classList.add("show", "alert", "alert-danger");
    errorText.textContent = message;

    // Ocultar la alerta después de 3 segundos
    setTimeout(function() {
        errorMessage.classList.remove("show");
        errorMessage.classList.add("fade");
    }, 3000);

    // Añadir un listener al botón de cierre
    closeButton.addEventListener('click', function() {
        errorMessage.classList.remove("show");
        errorMessage.classList.add("fade");
    });
}
