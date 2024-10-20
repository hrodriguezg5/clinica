import { apiService } from '../services/apiService.js';
import { showAlert } from '../utils/showArlert.js';
import { 
    createButton, 
    assignModalEvent, 
    assignFormSubmitEvent, 
    assignSearchEvent,
    closeModal,
    resetModal
} from '../utils/actionButton.js';

let currentData;
let currentModule;

export async function initModule(data, module) {
    currentData = data;
    currentModule = module;
    const url = `${urlBase}/${currentModule}/mostrar`;
    const response = await apiService.fetchData(url, 'GET');
    const tableBody = document.getElementById('tableBody');
    const tableHead = document.getElementById('tableHead');
    const addButton = document.getElementById('addButton');
    const moduleData = currentData.modules.find(moduleData => moduleData.link === currentModule);

    const canCreate = moduleData.create_operation === 1;
    const canUpdate = moduleData.update_operation === 1;
    const canDelete = moduleData.delete_operation === 1;
    const hasActions = canUpdate || canDelete;
    let rows = '';

    if (canCreate) {
        addButton.innerHTML = `
            <div class="rounded ps-4">
                <button type="button" class="btn btn-primary fw-bold btn-insert" data-bs-toggle="modal" data-bs-target="#insertModal">Agregar</button>
            </div>
        `;
    } else {
        addButton.innerHTML = ''; // Si no hay permisos, limpiar el contenedor
    }

    if (hasActions) {
        if (!document.querySelector('th.action-column')) {
            const actionHeader = document.createElement('th');
            actionHeader.scope = 'col';
            actionHeader.textContent = 'Acción';
            actionHeader.classList.add('action-column');
            tableHead.querySelector('tr').appendChild(actionHeader);
        }
    }

    response.forEach(item => {
        const dataInfo = JSON.stringify({patient_id: item.id}).replace(/"/g, '&quot;');
        let actionButtons = '';
        
        // Crear los botones de acuerdo a los permisos
        if (canUpdate) {
            actionButtons += createButton('btn-primary btn-update', 'Editar', dataInfo, 'updateModal', 'bi bi-pencil');
        }
        if (canDelete) {
            actionButtons += createButton('btn-danger btn-delete', 'Borrar', dataInfo, 'deleteModal', 'bi bi-trash-fill');
        }

        rows += `
            <tr>
                <td>${item.full_name}</td>
                <td>${item.email}</td>
                <td>${item.gender}</td>
                <td>${item.address}</td>
                <td>${item.phone}</td>
                <td>${item.birth_date}</td>
                ${hasActions ? `<td><div class="d-flex">${actionButtons}</div></td>` : ''}
            </tr>
        `;
    });
    
    tableBody.innerHTML = rows;
    
    assignSearchEvent('searchInput', 'tableBody', [0, 1, 2]);

    if (hasActions) {
        assignModalEvent('.btn-update', updateModal);
        assignModalEvent('.btn-delete', deleteModal);
    }

    assignFormSubmitEvent('insertForm', insertFormSubmit);
    assignFormSubmitEvent('updateForm', updateFormSubmit);
    assignFormSubmitEvent('deleteForm', deleteFormSubmit);

    resetModal('insertModal', 'insertForm');
}

const insertFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/agregar`;
    
    const formData = () => ({
        first_name: document.getElementById('insModFirstName').value || '',
        last_name: document.getElementById('insModLastName').value || '',
        email: document.getElementById('insModEmail').value || '',
        gender: document.getElementById('insModGender').value || '',
        address: document.getElementById('insModAddress').value || '',
        phone: document.getElementById('insModPhone').value || '',
        birth_date: document.getElementById('insModBirthDate').value || '',
        created_by: currentData.user_id || null,
        updated_by: currentData.user_id || null
    });
    
    try {
        await apiService.fetchData(url, 'POST', formData());
        showAlert("Operación exitosa.", 'success');
        closeModal('insertModal');
    } catch (error) {
        showAlert("Error de conexión.", 'danger');
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};

const updateModal = async (data) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const id = data.patient_id;

    try {
        const response = await apiService.fetchData(url, 'POST', { id });

        document.getElementById('updateForm').setAttribute('data-info', dataInfo);
        document.getElementById('updModFirstName').value = response.first_name || '';
        document.getElementById('updModLastName').value = response.last_name || '';
        document.getElementById('updModEmail').value = response.email || '';
        document.getElementById('updModGender').value = response.gender || '';
        document.getElementById('updModAddress').value = response.address || '';
        document.getElementById('updModPhone').value = response.phone || '';
        document.getElementById('updModBirthDate').value = response.birth_date || '';
    } catch (error) {
        console.error('Error:', error);
    }
};


const updateFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/actualizar`;
    const dataInfo = JSON.parse(document.getElementById('updateForm').getAttribute('data-info'));

    const formData = () => ({
        first_name: document.getElementById('updModFirstName').value || '',
        last_name: document.getElementById('updModLastName').value || '',
        email: document.getElementById('updModEmail').value || '',
        gender: document.getElementById('updModGender').value || '',
        address: document.getElementById('updModAddress').value || '',
        phone: document.getElementById('updModPhone').value || '',
        birth_date: document.getElementById('updModBirthDate').value || '',
        updated_by: currentData.user_id || null,
        id: dataInfo.patient_id || null
    });
    
    try {
        await apiService.fetchData(url, 'POST', formData());
        showAlert("Operación exitosa.", 'success');
        closeModal('updateModal');
    } catch (error) {
        showAlert("Error de conexión.", 'danger');
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};

const deleteModal = async (data) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const id = data.patient_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { id });
        const name = response.first_name + ' ' + response.last_name;

        document.getElementById('deleteForm').setAttribute('data-info', dataInfo);
        document.getElementById('delModName').innerText = name || '';
        document.getElementById('delModEmail').innerText = response.email || '';
        document.getElementById('delModGender').innerText = response.gender || '';
        document.getElementById('delModAddress').innerText = response.address || '';
        document.getElementById('delModPhone').innerText = response.phone || '';
        document.getElementById('delModBirthDate').innerText = response.birth_date || '';

    } catch (error) {
        console.error('Error:', error);
    }
};

const deleteFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/eliminar`;
    const dataInfo = JSON.parse(document.getElementById('deleteForm').getAttribute('data-info'));

    const formData = () => ({
        deleted_by: currentData.user_id || null,
        id: dataInfo.patient_id || null
    });

    try {
        await apiService.fetchData(url, 'POST', formData());
        showAlert("Operación exitosa.", 'success');
        closeModal('deleteModal');
    } catch (error) {
        showAlert("Error de conexión.", 'danger');
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};