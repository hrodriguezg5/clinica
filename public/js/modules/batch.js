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
            populateSelectMedicine('insModMedicine', 'medicina');
            populateSelectSupplier('insModSupplier', 'proveedor');
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
        const dataInfo = JSON.stringify({batch_id: item.id}).replace(/"/g, '&quot;');

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
                <td>${item.id}</td>
                <td>${item.medicine_name}</td>
                <td>${item.supplier_name}</td>
                <td>${item.quantity}u.</td>
                <td>${item.created_at}</td>
                <td>${item.expiration_date}</td>
                ${hasActions ? `<td><div class="d-flex">${actionButtons}</div></td>` : ''}
            </tr>
        `;
    });
    
    tableBody.innerHTML = rows;
    
    assignSearchEvent('searchInput', 'tableBody', [0, 1, 2, 3]);

    if (hasActions) {
        assignModalEvent('.btn-update', updateModal);
        assignModalEvent('.btn-delete', deleteModal);
    }

    assignFormSubmitEvent('insertForm', insertFormSubmit);
    assignFormSubmitEvent('updateForm', updateFormSubmit);
    assignFormSubmitEvent('deleteForm', deleteFormSubmit);

    resetModal('insertModal', 'insertForm');
}

const populateSelectMedicine = async (selectId, module) =>  {
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
                option.textContent = item.name + ' - ' + item.brand;
                newSelectElement.appendChild(option);
            }
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

const populateSelectSupplier = async (selectId, module) =>  {
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
                option.textContent = item.name;;
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
        medicine_id: Number(document.getElementById('insModMedicine').value) || null,
        supplier_id: Number(document.getElementById('insModSupplier').value) || null,
        quantity: Number(document.getElementById('insModQuantity').value) || null,
        expiration_date: document.getElementById('insModExpirationDate').value || '',
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
    const id = data.batch_id;

    await populateSelectMedicine('updModMedicine', 'medicina');
    await populateSelectSupplier('updModSupplier', 'proveedor');

    try {
        const response = await apiService.fetchData(url, 'POST', { id });
        const medicineSelect = document.getElementById('updModMedicine');
        const supplierSelect = document.getElementById('updModSupplier');
        const medicineOption = Array.from(medicineSelect.options).find(option => option.text.includes(response.medicine_name));
        const supplierOption = Array.from(supplierSelect.options).find(option => option.text === response.supplier_name);
        
        document.getElementById('updateForm').setAttribute('data-info', dataInfo);
        document.getElementById('updModBatchId').value = response.id || '';
        document.getElementById('updModMedicine').value = medicineOption.value || '';
        document.getElementById('updModSupplier').value = supplierOption.value || '';
        document.getElementById('updModQuantity').value = response.quantity || '';
        document.getElementById('updModCreatedAt').value = response.created_at || '';
        document.getElementById('updModExpirationDate').value = response.expiration_date || '';
    } catch (error) {
        console.error('Error:', error);
    }

    resetModal('updateModal', 'updateForm');
};

const updateFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/actualizar`;
    const dataInfo = JSON.parse(document.getElementById('updateForm').getAttribute('data-info'));

    const formData = () => ({
        medicine_id: Number(document.getElementById('updModMedicine').value) || null,
        supplier_id: Number(document.getElementById('updModSupplier').value) || null,
        quantity: Number(document.getElementById('updModQuantity').value) || null,
        expiration_date: document.getElementById('updModExpirationDate').value || null,
        updated_by: currentData.user_id || null,
        id: dataInfo.batch_id || null
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
    const id = data.batch_id;
    
    try {
        const response = await apiService.fetchData(url, 'POST', { id });

        document.getElementById('deleteForm').setAttribute('data-info', dataInfo);
        document.getElementById('delModBatchId').innerText = response.id || '';
        document.getElementById('delModMedicine').innerText = response.medicine_name || '';
        document.getElementById('delModSupplier').innerText = response.supplier_name || '';
        document.getElementById('delModQuantity').innerText = response.quantity || '';
        document.getElementById('delModCreatedAt').innerText = response.created_at || '';
        document.getElementById('delModExpirationDate').innerText = response.expiration_date || '';
    } catch (error) {
        console.error('Error:', error);
    }
};

const deleteFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/eliminar`;
    const dataInfo = JSON.parse(document.getElementById('deleteForm').getAttribute('data-info'));

    const formData = () => ({
        deleted_by: currentData.user_id || null,
        id: dataInfo.batch_id || null
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