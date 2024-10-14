import { apiService } from '../services/apiService.js';
import { 
    createButton, 
    assignModalEvent, 
    assignFormSubmitEvent, 
    assignSearchEvent 
} from '../utils/actionButton.js';

let currentModule;

export async function initModule(data, module) {
    currentModule = module;
    const url = `${urlBase}/${currentModule}/mostrar`;
    const response = await apiService.fetchData(url, 'GET');
    const tableBody = document.getElementById('tableBody');
    // const moduleData = data.modules.find(moduleData => moduleData.link === currentModule);

    console.log('Módulo:', data);
    // console.log('Módulo:', moduleData);
    let rows = '';

    response.forEach(item => {
        const dataInfo = JSON.stringify({role_id: item.id, role: item.role, user_id: data.user_id}).replace(/"/g, '&quot;');
        const status = item.active ? 'Activo' : 'Inactivo';
        const alertType = item.active ? 'success' : 'danger';

        rows += `
            <tr>
                <td>${item.role}</td>
                <td>${item.description}</td>
                <td><span class="badge bg-${alertType}">${status}</span></td>
                <td>
                    <div class="d-flex">
                        ${createButton('btn-secondary btn-permission', 'Permiso', dataInfo, '#permissionRoleModal', 'bi bi-key')}
                        ${createButton('btn-primary btn-update', 'Editar', dataInfo, '#updateRoleModal', 'bi bi-pencil')}
                        ${createButton('btn-danger btn-delete', 'Borrar', dataInfo, '#deleteRoleModal', 'bi bi-trash-fill')}
                    </div>
                </td>
            </tr>
        `;
    });
    tableBody.innerHTML = rows;

    assignModalEvent('.btn-permission', permissionRoleModal, 'permiso');
    assignModalEvent('.btn-update', updateRoleModal, currentModule);
    // assignModalEvent('.btn-delete', deleteRoleModal, module);

    assignFormSubmitEvent('permissionForm', permissionFormSubmit, currentModule);
    assignFormSubmitEvent('updateRoleForm', updateFormSubmit, currentModule);
    // assignFormSubmitEvent('permissionForm', deleteFormSubmit, module);

    assignSearchEvent('searchInput', 'tableBody', [0, 1, 2]);
}

const permissionRoleModal = async (data) => {
    console.log(currentModule);
    const url = `${urlBase}/permiso/filtrar`;
    const { role_id, role, user_id} = data;

    try {
        const response = await apiService.fetchData(url, 'POST', { role_id });
        const modulesTableBody = document.getElementById('permmissionTableBody');
        const permissionModalTitle = document.getElementById('permissionModalTitle');
        permissionModalTitle.textContent = `Permisos de ${role}`;

        let rows = '';
        response.forEach(item => {
            const showChecked = item.show_operation ? 'checked' : '';
            const createChecked = item.create_operation ? 'checked' : '';
            const updateChecked = item.update_operation ? 'checked' : '';
            const deleteChecked = item.delete_operation ? 'checked' : '';
            const inputs = 'input class="form-check-input" type="checkbox" role="switch"';
            const classes = 'class="form-check form-switch d-flex justify-content-center"';

            rows += `
                <tr mp-id="${item.id}" mr-id="${role_id}" mm-id="${item.module_id}"mu-id="${user_id}">
                    <td class="text-start">${item.module}</td>
                    <td><div ${classes}><${inputs} ${showChecked}></div></td>
                    <td><div ${classes}><${inputs} ${createChecked}></div></td>
                    <td><div ${classes}><${inputs} ${updateChecked}></div></td>
                    <td><div ${classes}><${inputs} ${deleteChecked}></div></td>
                </tr>
            `;
        });
        modulesTableBody.innerHTML = rows;
    } catch (error) {
        console.error('Error:', error);
    }
};

const permissionFormSubmit = async () => {
    const modalElement = document.getElementById('permissionRoleModal');
    const modalInstance = bootstrap.Modal.getInstance(modalElement);
    const urlInsert = `${urlBase}/permiso/agregar`;
    const urlUpdate = `${urlBase}/permiso/actualizar`;
    const rows = document.querySelectorAll('#permmissionTableBody tr');

    const promises = Array.from(rows).map(async row => {
        const id = row.getAttribute('mp-id');
        const url = id === '0' ? urlInsert : urlUpdate;
        const formData = () => ({
            id: row.getAttribute('mp-id'),
            role_id: row.getAttribute('mr-id'),
            module_id: row.getAttribute('mm-id'),
            show_operation: row.querySelectorAll('input[type="checkbox"]')[0].checked ? 1 : 0,
            create_operation: row.querySelectorAll('input[type="checkbox"]')[1].checked ? 1 : 0,
            update_operation: row.querySelectorAll('input[type="checkbox"]')[2].checked ? 1 : 0,
            delete_operation: row.querySelectorAll('input[type="checkbox"]')[3].checked ? 1 : 0,
            user_id: row.getAttribute('mu-id')
        });

        try {
            return await apiService.fetchData(url, 'POST', formData());
        } catch (error) {
            console.error('Error:', error);
        }
    });

    await Promise.all(promises);
    modalInstance.hide();
};

const updateRoleModal = async (data, module) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const role_id = data.role_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { role_id });
        const status = response.active ? 'Activo' : 'Inactivo';
        document.getElementById('updateRoleForm').setAttribute('data-info', dataInfo);
        document.getElementById('upModName').value = response.role || null;
        document.getElementById('upModDescription').innerText = response.description || null;
        document.getElementById('upModStatus').value = status || null;
    } catch (error) {
        console.error('Error:', error);
    }
};

const updateFormSubmit = async () => {
    const url = `${urlBase}/rol/actualizar`;
    const dataInfo = JSON.parse(document.getElementById('updateRoleForm').getAttribute('data-info'));
    const status = document.getElementById('upModStatus').value === 'Activo' ? 1 : 0;

    const formData = () => ({
        name: document.getElementById('upModName').value || null,
        description: document.getElementById('upModDescription').value || null,
        active: status,
        user_id: dataInfo.user_id || null,
        role_id: dataInfo.role_id || null
    });
    
    try {
        await apiService.fetchData(url, 'POST', formData());
        const modalElement = document.getElementById('updateRoleModal');
        const modalInstance = bootstrap.Modal.getInstance(modalElement);
        modalInstance.hide();
    } catch (error) {
        console.error('Error:', error);
    }

    await initModule(dataInfo, 'rol');
};