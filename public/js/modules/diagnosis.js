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
            populateSelect('insModPatient', 'paciente');
            populateSelectDoctor('insModDoctor', 'empleado');
            populateSelect('insModBranch', 'sucursal');
            populateSelectExams('insModExams', 'examen');
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
        const dataInfo = JSON.stringify({diagnosis_id: item.id}).replace(/"/g, '&quot;');
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
                <td>${item.patient_name}</td>
                <td>${item.employee_name}</td>
                <td>${item.branch_name}</td>
                <td>${item.visit_date}</td>
                <td>${item.diagnosis}</td>
                <td>${item.exams}</td>
                <td>${item.treatment_plan}</td>
                ${hasActions ? `<td><div class="d-flex">${actionButtons}</div></td>` : ''}
            </tr>
        `;
    });
    
    tableBody.innerHTML = rows;
    
    assignSearchEvent('searchInput', 'tableBody', [0, 1, 2, 3, 4, 5, 6]);

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

const populateSelectDoctor = async (selectId, module) =>  {
    const select = document.getElementById(selectId);
    const newSelect = select.outerHTML;
    select.outerHTML = newSelect;

    const newSelectElement = document.getElementById(selectId);
    newSelectElement.innerHTML = '';
    
    try {
        const options = await apiService.fetchData(`${urlBase}/${module}/mostrar`, 'GET');
        options.forEach(item => {
            if (item.active === 1 && item.patient_care === 1) {
                const option = document.createElement('option');
                option.value = item.id;
                option.textContent = item.employee_name;
                newSelectElement.appendChild(option);
            }
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

const populateSelectExams = async (dropdownId, module) => {
    const dropdownMenu = document.querySelector(`#${dropdownId} + .dropdown-menu`);
    dropdownMenu.innerHTML = '';

    try {
        const options = await apiService.fetchData(`${urlBase}/${module}/mostrar`, 'GET');
        options.forEach(item => {
            if (item.active === 1) {
                const listItem = document.createElement('li');
                listItem.innerHTML = `
                    <div class="form-check ms-3">
                        <input class="form-check-input" type="checkbox" value="${item.name}" id="option${item.id}">
                        <label class="form-check-label" for="option${item.id}">${item.name}</label>
                    </div>
                `;
                dropdownMenu.appendChild(listItem);
            }
        });
    } catch (error) {
        console.error('Error:', error);
    }
};

const insertFormSubmit = async () => {
    const url = `${urlBase}/${currentModule}/agregar`;
    
    const formData = () => ({
        patient_id: Number(document.getElementById('insModPatient').value) || null,
        employee_id: Number(document.getElementById('insModDoctor').value) || '',
        branch_id: Number(document.getElementById('insModBranch').value) || '',
        visit_date: document.getElementById('insModVisitDate').value || '',
        diagnostico: document.getElementById('insModDiagnosis').value || '',
        created_by: currentData.user_id || null,
        updated_by: currentData.user_id || null
    });
    
    await examsFormSubmit();

    // try {
    //     await apiService.fetchData(url, 'POST', formData());
    //     showAlert("Operación exitosa.", 'success');
    //     closeModal('insertModal');
    // } catch (error) {
    //     showAlert("Error de conexión.", 'danger');
    //     console.error('Error:', error);
    // }

    // await initModule(currentData, currentModule);
};

const examsFormSubmit = async () => {
     const urlInsert = `${urlBase}/pacienteexamen/agregar`;
    const urlUpdate = `${urlBase}/pacienteexamen/actualizar`;

    const selectedExams = Array.from(document.querySelectorAll('#insModExams + .dropdown-menu input:checked'))
        .map(checkbox => ({
            exam_id: Number(checkbox.id.replace('option', ''))
        }));
    
            
   
    // const rows = document.querySelectorAll('#permmissionTableBody tr');

    // const promises = Array.from(rows).map(async row => {
    //     const id = row.getAttribute('mp-id');
    //     const url = id === '0' ? urlInsert : urlUpdate;
    //     const formData = () => ({
    //         id: row.getAttribute('mp-id'),
    //         role_id: row.getAttribute('mr-id'),
    //         module_id: row.getAttribute('mm-id'),
    //         show_operation: row.querySelectorAll('input[type="checkbox"]')[0].checked ? 1 : 0,
    //         create_operation: row.querySelectorAll('input[type="checkbox"]')[1].checked ? 1 : 0,
    //         update_operation: row.querySelectorAll('input[type="checkbox"]')[2].checked ? 1 : 0,
    //         delete_operation: row.querySelectorAll('input[type="checkbox"]')[3].checked ? 1 : 0,
    //         user_id: currentData.user_id || null
    //     });

    //     try {
    //         showAlert("Operación exitosa.", 'success');
    //         return await apiService.fetchData(url, 'POST', formData());
    //     } catch (error) {
    //         showAlert("Error de conexión.", 'danger');
    //         console.error('Error:', error);
    //     }
    // });

    // await Promise.all(promises);
    // closeModal('permissionModal');
};

const updateModal = async (data) => {
    const url = `${urlBase}/${currentModule}/filtrar`;
    const dataInfo = JSON.stringify(data);
    const id = data.patient_id;

    try {
        const response = await apiService.fetchData(url, 'POST', { id });

        document.getElementById('updateForm').setAttribute('data-info', dataInfo);
        document.getElementById('updModPatientCode').value = response.id || '';
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
        document.getElementById('delModPatientCode').innerText = response.id || '';
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