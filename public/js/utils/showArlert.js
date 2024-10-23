export function showAlert(message, alertType) {
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    const closeButton = document.getElementById('closeButton');

    // Restablecer la alerta si fue cerrada manualmente
    errorMessage.classList.remove('fade', 'slide-out');
    errorMessage.classList.add('show', 'alert', `alert-${alertType}`, 'slide-in');
    errorText.textContent = message;

    // Ocultar la alerta después de 3 segundos
    setTimeout(function() {
        errorMessage.classList.remove('show', 'slide-in', `alert-${alertType}`);
        errorMessage.classList.add('fade', 'slide-out');
    }, 4500);

    // Añadir un listener al botón de cierre
    closeButton.addEventListener('click', function() {
        errorMessage.classList.remove('show', 'slide-in', `alert-${alertType}`);
        errorMessage.classList.add('fade', 'slide-out');
    });
}