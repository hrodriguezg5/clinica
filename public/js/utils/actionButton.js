import { apiService } from '../services/apiService.js';

export function createButton(btnClass, title, dataInfo, targetModal, iconClass) {
    return `
        <button
            type="button"
            class="btn btn-sm ${btnClass} me-1"
            title="${title}"
            data-info="${dataInfo}"
            data-bs-toggle="modal"
            data-bs-target="#${targetModal}">
            <i class="bi ${iconClass}"></i>
        </button>
    `;
}

export async function assignModalEvent(selector, handler, module) {
    // Seleccionar todos los botones con el selector
    document.querySelectorAll(selector).forEach(button => {
        // Reemplazar el contenido del botón por su HTML para eliminar eventos anteriores
        const newButton = button.outerHTML;
        button.outerHTML = newButton;
    });

    // Seleccionar todos los nuevos botones nuevamente después de haber reemplazado su HTML
    document.querySelectorAll(selector).forEach(newButtonElement => {
        // Asignar el nuevo evento de click
        newButtonElement.addEventListener('click', async () => {
            const url = `${urlBase}/login/token`;
            const data = await apiService.fetchData(url, 'GET');

            if (!data) {
                localStorage.setItem('tokenExpired', 'true');
                window.location.href = urlBase;
                return;
            }
            
            const dataInfo = JSON.parse(newButtonElement.getAttribute('data-info'));
            handler(dataInfo);
        });
    });
}


export async function assignFormSubmitEvent(id, handler, module) {
    const form = document.getElementById(id);

    if (form) {
        // Reemplaza el contenido del formulario por su HTML para remover cualquier evento anterior
        const newForm = form.outerHTML;
        form.outerHTML = newForm;

        // Obtener de nuevo el nuevo formulario
        const newFormElement = document.getElementById(id);

        // Asignar el nuevo evento de submit
        newFormElement.addEventListener('submit', async (event) => {
            event.preventDefault();
            const url = `${urlBase}/login/token`;
            const data = await apiService.fetchData(url, 'GET');

            if (!data) {
                localStorage.setItem('tokenExpired', 'true');
                window.location.href = urlBase;
                return;
            }

            handler();
        });
    }
}

export async function assignSearchEvent(inputSelector, tableSelector, columns) {
    const searchInput = document.getElementById(inputSelector);
    const tableBody = document.getElementById(tableSelector);

    if (searchInput && tableBody) {
        searchInput.addEventListener('keyup', async () => {
            const input = searchInput.value.toLowerCase();
            const rows = tableBody.getElementsByTagName('tr');

            for (let i = 0; i < rows.length; i++) {
                let shouldDisplay = false;

                for (let col of columns) {
                    const cell = rows[i].getElementsByTagName('td')[col];
                    if (cell && cell.textContent.toLowerCase().includes(input)) {
                        shouldDisplay = true;
                        break;
                    }
                }

                rows[i].style.display = shouldDisplay ? '' : 'none';
            }
        });
    }
}

export const closeModal = (modalId) => {
    const modalElement = document.getElementById(modalId);
    const modalInstance = bootstrap.Modal.getInstance(modalElement);
    if (modalInstance) {
        modalInstance.hide();
    }
};