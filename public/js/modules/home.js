export function initModule(data, module) {
    const greetingTitle = document.getElementById("greetingTitle");
    greetingTitle.textContent = `¡Hola ${data.first_name}!`;
}
