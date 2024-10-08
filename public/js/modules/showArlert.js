export function showAlert(message) {
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    errorMessage.classList.add("show", 'alert', 'alert-danger');
    errorText.textContent = message;
    setTimeout(function() {
        errorMessage.classList.remove("show");
    }, 3000);
}
