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

        const insertModal = document.getElementById('insertModal');
        insertModal.addEventListener('show.bs.modal', () => {
            populateSelect('insModBranch', 'sucursal');
        });

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
        const dataInfo = JSON.stringify({room_id: item.id}).replace(/"/g, '&quot;');
        const status = item.active ? 'Activo' : 'Inactivo';
        const alertType = item.active ? 'success' : 'danger';

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
                <td>${item.name}</td>
                <td class="${item.branch_name ? '' : 'text-danger'}">${item.branch_name}</td>
                <td><span class="badge bg-${alertType}">${status}</span></td>
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

const populateSelect = async (selectId, module) =>  {
    const select = document.getElementById(selectId);
    const newSelect = select.outerHTML;
    select.outerHTML = newSelect;

    const newSelectElement = document.getElementById(selectId);
    newSelectElement.innerHTML = '';
    
    try {
        const options = await apiService.fetchData(`${urlBase}/${module}/mostrar`, 'GET');
        options.forEach(item => {
            if (item.active === 1) {
                const option = document.createElement('option');
                option.value = item.id;
                option.textContent = item.name;
                newSelectElement.appendChild(option);
            }
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

const insertFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/agregar`;

    const formData = () => ({
        name: document.getElementById('insModName').value || '',
        branch_id: Number(document.getElementById('insModBranch').value) || null,
        active: Number(document.getElementById('insModStatus').value),
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
    const id = data.room_id;
    
    await populateSelect('updModBranch', 'sucursal');
    
    try {
        const response = await apiService.fetchData(url, 'POST', { id });
        const branchSelect = document.getElementById('updModBranch');
        const branchOption = Array.from(branchSelect.options).find(option => option.text === response.branch_name);
        
        document.getElementById('updateForm').setAttribute('data-info', dataInfo);
        document.getElementById('updModName').value = response.name || '';
        document.getElementById('updModBranch').value = branchOption ? branchOption.value : '';
        document.getElementById('updModStatus').value = response.active.toString() || '';
    } catch (error) {
        console.error('Error:', error);
    }

    resetModal('updateModal', 'updateForm');
};


const updateFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/actualizar`;
    const dataInfo = JSON.parse(document.getElementById('updateForm').getAttribute('data-info'));
    
    const formData = () => ({
        name: document.getElementById('updModName').value || '',
        branch_id: Number(document.getElementById('updModBranch').value) || null,
        active: Number(document.getElementById('updModStatus').value),
        updated_by: currentData.user_id || null,
        id: dataInfo.room_id || null,
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
    const id = data.room_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { id });
        const status = response.active ? 'Activo' : 'Inactivo';

        document.getElementById('deleteForm').setAttribute('data-info', dataInfo);
        document.getElementById('delModName').innerText = response.name || '';
        document.getElementById('delModBranch').innerText = response.branch_name || '';
        document.getElementById('delModStatus').innerText = status || '';
    } catch (error) {
        console.error('Error:', error);
    }
};

const deleteFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/eliminar`;
    const dataInfo = JSON.parse(document.getElementById('deleteForm').getAttribute('data-info'));

    const formData = () => ({
        deleted_by: currentData.user_id || null,
        id: dataInfo.room_id || null
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