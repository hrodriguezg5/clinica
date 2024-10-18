import { apiService } from '../services/apiService.js';
import { isValidPassword } from '../utils/validation.js';
import { showAlert } from '../utils/showArlert.js';
import { 
    createButton, 
    assignModalEvent, 
    assignFormSubmitEvent, 
    assignSearchEvent,
    closeModal
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
        insertModal.addEventListener('show.bs.modal', populateRoles);
    } else {
        addButton.innerHTML = ''; // Si no hay permisos, limpiar el contenedor
    }

    if (hasActions) {
        // Verificar si ya existe la columna "Acción" para evitar duplicados
        if (!document.querySelector('th.action-column')) {
            const actionHeader = document.createElement('th');
            actionHeader.scope = 'col';
            actionHeader.textContent = 'Acción';
            actionHeader.classList.add('action-column');
            tableHead.querySelector('tr').appendChild(actionHeader);
        }
    }

    response.forEach(item => {
        const dataInfo = JSON.stringify({user_id: item.id}).replace(/"/g, '&quot;');
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

        // Si existen acciones permitidas, agregamos el <td> de acciones
        rows += `
            <tr>
                <td>${item.user_name}</td>
                <td>${item.username}</td>
                <td>${item.role_name}</td>
                <td><span class="badge bg-${alertType}">${status}</span></td>
                ${hasActions ? `<td><div class="d-flex">${actionButtons}</div></td>` : ''}
            </tr>
        `;
    });
    
    tableBody.innerHTML = rows;
    
    assignSearchEvent('searchInput', 'tableBody', [0, 1, 2]);

    if (hasActions) {
        assignModalEvent('.btn-update', updateModal, currentModule);
        assignModalEvent('.btn-delete', deleteModal, currentModule);
    }

    assignFormSubmitEvent('insertForm', insertFormSubmit, currentModule);
    assignFormSubmitEvent('updateForm', updateFormSubmit, currentModule);
    assignFormSubmitEvent('deleteForm', deleteFormSubmit, currentModule);

}

const populateRoles = async () =>  {
    const selectRole = document.getElementById('insModRole');
    selectRole.innerHTML = ''; // Limpiar el select antes de añadir nuevos roles
    try {
        const roles = await apiService.fetchData(`${urlBase}/rol/mostrar`, 'GET');
        roles.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;  // Almacenar el ID del rol
            option.textContent = item.role;  // Mostrar el nombre del rol
            selectRole.appendChild(option);
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

const insertFormSubmit = async () => {
    const urlInsert = `${urlBase}/${currentModule}/agregar`;
    const urlSearch = `${urlBase}/${currentModule}/buscar`;
    const password = document.getElementById('insModPassword');
    const username =  document.getElementById('insModUsername');

    username.addEventListener('input', function() {
        this.classList.remove('input-error');
    });

    password.addEventListener('input', function() {
        this.classList.remove('input-error');
    });

    try {
        const response = await apiService.fetchData(urlSearch, 'POST', {username: username.value });
        if (response.username === username.value) {
            showAlert('El usuario ya se encuentra registrado.', 'danger');
            username.classList.add('input-error');
            return;
        }
    } catch (error) {
        console.error('Error:', error);
    }

    if (!isValidPassword(password.value)) {
        showAlert('La contraseña debe tener al menos 8 caracteres, incluyendo una letra y un número.', 'danger');
        password.classList.add('input-error');
        return;
    }
    
    const formData = () => ({
        first_name: document.getElementById('insModFirstName').value || null,
        last_name: document.getElementById('insModLastName').value || null,
        username: username.value || null,
        role_id: document.getElementById('insModRole').value || null,
        active: document.getElementById('insModStatus').value || null,
        password: password.value || null,
        user_id: currentData.user_id || null
    });
    
    try {
        await apiService.fetchData(urlInsert, 'POST', formData());
        closeModal('insertModal');
    } catch (error) {
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};

const updateRoleModal = async (data) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const role_id = data.role_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { role_id });
        const status = response.active ? 'Activo' : 'Inactivo';
        document.getElementById('updateRoleForm').setAttribute('data-info', dataInfo);
        document.getElementById('updModName').value = response.role || null;
        document.getElementById('updModDescription').innerText = response.description || null;
        document.getElementById('updModStatus').value = status || null;
    } catch (error) {
        console.error('Error:', error);
    }
};

const updateFormSubmit = async () => {
    const url = `${urlBase}/rol/actualizar`;
    const dataInfo = JSON.parse(document.getElementById('updateRoleForm').getAttribute('data-info'));
    const status = document.getElementById('updModStatus').value === 'Activo' ? 1 : 0;

    const formData = () => ({
        name: document.getElementById('updModName').value || null,
        description: document.getElementById('updModDescription').value || null,
        active: status,
        user_id: currentData.user_id || null,
        role_id: dataInfo.role_id || null
    });
    
    try {
        await apiService.fetchData(url, 'POST', formData());
        closeModal('updateRoleModal');
    } catch (error) {
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};

const deleteRoleModal = async (data) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const role_id = data.role_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { role_id });
        const status = response.active ? 'Activo' : 'Inactivo';
        document.getElementById('deleteRoleForm').setAttribute('data-info', dataInfo);
        document.getElementById('delModName').innerText = response.role || null;
        document.getElementById('delModDescription').innerText = response.description || null;
        document.getElementById('delModStatus').innerText = status || null;
    } catch (error) {
        console.error('Error:', error);
    }
};

const deleteFormSubmit = async () => {
    const url = `${urlBase}/rol/eliminar`;
    const dataInfo = JSON.parse(document.getElementById('deleteRoleForm').getAttribute('data-info'));
    const status = document.getElementById('delModStatus').innerText === 'Activo' ? 1 : 0;

    const formData = () => ({
        name: document.getElementById('delModName').innerText || null,
        description: document.getElementById('delModDescription').innerText || null,
        active: status,
        user_id: currentData.user_id || null,
        role_id: dataInfo.role_id || null
    });

    try {
        await apiService.fetchData(url, 'POST', formData());
        closeModal('deleteRoleModal');
    } catch (error) {
        console.error('Error:', error);
    }

    await initModule(currentData, currentModule);
};