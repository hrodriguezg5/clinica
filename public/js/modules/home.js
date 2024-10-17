export function initModule(data, module) {
    const greetingTitle = document.getElementById("greetingTitle");
    const moduleData = data.modules.find(moduleData => moduleData.link === module);
    greetingTitle.textContent = `¡Hola ${data.first_name}!`;
}
