import { apiService } from '../services/apiService.js';

export function createButton(btnClass, title, dataInfo, targetModal, iconClass) {
    return `
        <button
            type="button"
            class="btn btn-sm ${btnClass} me-1"
            title="${title}"
            data-info="${dataInfo}"
            data-bs-toggle="modal"
            data-bs-target="${targetModal}">
            <i class="bi ${iconClass}"></i>
        </button>
    `;
}

export async function assignModalEvent(selector, handler, module) {
    document.querySelectorAll(selector).forEach(button => {
        button.addEventListener('click', async  () => {
            const url = `${urlBase}/${module}/token`;
            const data = await apiService.fetchData(url, 'GET');
    
            if (!data) {
                window.location.href = urlBase;
                return;
            }
            const dataInfo = JSON.parse(button.getAttribute('data-info'));
            handler(dataInfo);
        });
    });
}

export async function assignFormSubmitEvent(id, handler, module) {
    const form = document.getElementById(id);
    if (form) {
        form.addEventListener('submit', async (event) => {
            event.preventDefault();
            const url = `${urlBase}/${module}/token`;
            const data = await apiService.fetchData(url, 'GET');

            if (!data) {
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