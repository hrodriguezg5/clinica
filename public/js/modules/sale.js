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
let rows = '';

export async function initModule(data, module) {
    currentData = data;
    currentModule = module;
    await populateSelect('addMedicine', 'medicina');
    await populateSelect('addBranch', 'sucursal');

    document.getElementById('addBranch').addEventListener('change', async function () {
        document.getElementById('addMedicine').value = '';
        document.getElementById('addSalePrice').value = '';
        document.getElementById('addStock').value = '';
    });

    document.getElementById('addMedicine').addEventListener('change', async function () {
        const selectedBranch = document.getElementById('addBranch').value

        if (!selectedBranch) {
            document.getElementById('addMedicine').value = '';
            showAlert("Seleccione una sucursal.", 'warning');
            return;
        }

        const selectedMedicine = this.value;
        await populateInput(selectedMedicine, selectedBranch);
        const totalRegisteredQuantity = await getTotalQuantityFromTable(selectedMedicine, selectedBranch);
        const currentStock = Number(document.getElementById('addStock').value) || 0;
        const availableStock = currentStock - totalRegisteredQuantity;
        const stock = document.getElementById('addStock');
        const quantity = document.getElementById('addQuantity');
        stock.value = availableStock >= 0 ? availableStock : 0;
        quantity.max = stock.value;
    });

    document.getElementById('resetButton').addEventListener('click', async function () {
        await resetForm();
        document.getElementById('finalizeButton').style.display = 'none';
        document.getElementById('totalRow').style.display = 'none';
    });

    document.getElementById('addForm').addEventListener('submit', async function (event) {
        event.preventDefault();
        await addProduct();
        document.getElementById('addDate').disabled = true;
        document.getElementById('addCustomer').disabled = true;
        document.getElementById('addBranch').disabled = true;
        document.getElementById('addMedicine').value = '';
        document.getElementById('addSalePrice').value = '';
        document.getElementById('addStock').value = '';
        document.getElementById('addQuantity').value = '';
    });
    
};

const updateTotal = async () => {
    const tableBody = document.getElementById('tableBody');
    let totalSum = 0;

    // Verificar si hay filas en la tabla antes de iterar
    if (tableBody.rows.length > 0) {
        Array.from(tableBody.rows).forEach(row => {
            const rowTotal = parseFloat(row.cells[4]?.innerText.replace('Q', '')) || 0;
            totalSum += rowTotal;
        });
    }

    // Controlar la visibilidad de la fila de "Total"
    let totalRow = document.getElementById('totalRow');
    if (tableBody.rows.length > 0) {
        totalRow.style.display = '';
        document.getElementById('totalAmount').innerText = `Q${totalSum.toFixed(2)}`;
    } else {
        totalRow.style.display = 'none';
        await resetForm();
    }

    // Llamar a `showFinalizeButton` para actualizar el estado del botón "Finalizar Venta"
    await showFinalizeButton();
};

const showFinalizeButton = async () => {
    const finalizeButton = document.getElementById('finalizeButton');
    const tableBody = document.getElementById('tableBody');
    
    // Mostrar el botón solo si hay filas en la tabla
    finalizeButton.style.display = tableBody.rows.length > 0 ? 'inline-block' : 'none';
};

const getTotalQuantityFromTable = async (medicineId, branchId) => {
    const tableBody = document.getElementById('tableBody');
    let totalQuantity = 0;

    // Recorrer cada fila de la tabla para acumular la cantidad del medicamento y sucursal especificados
    Array.from(tableBody.rows).forEach(row => {
        const rowMedicineId = row.dataset.medicineId; // Obtiene medicine_id de data attribute
        const rowBranchId = row.dataset.branchId;     // Obtiene branch_id de data attribute
        const rowQuantity = Number(row.cells[2].innerText) || 0; // Cantidad de la columna correspondiente

        if (rowMedicineId === medicineId && rowBranchId === branchId) {
            totalQuantity += rowQuantity;
        }
    });

    return totalQuantity;
};

const resetForm = async () => {
    document.getElementById('addForm').reset();
    document.getElementById('tableBody').innerHTML = '';
    document.getElementById('addDate').disabled = false;
    document.getElementById('addCustomer').disabled = false;
    document.getElementById('addBranch').disabled = false;
};

const addProduct = async () => {
    const url = `${urlBase}/${currentModule}/mostrar`;
    const tableBody = document.getElementById('tableBody');

    const formData = () => ({
        id: document.getElementById('addMedicine').value || '',
        branch_id: document.getElementById('addBranch').value || '',
        quantity: Number(document.getElementById('addQuantity').value) || null
    });

    const response = await apiService.fetchData(url, 'POST', formData());

    response.forEach(item => {
        const row = document.createElement('tr');
        row.dataset.medicineId = item.medicine_id;
        row.dataset.branchId = item.branch_id;

        row.innerHTML = `
            <td>${item.medicine_name}</td>
            <td>${item.batch_id}</td>
            <td>${item.requested_quantity}</td>
            <td>Q${item.selling_price}</td>
            <td>Q${item.total_amount.toFixed(2)}</td>
            <td><button class="btn btn-danger btn-sm delete-button">
                    <i class="bi bi bi-trash-fill"></i>
                </button>
            </td>
        `;

        // Agregar el evento de eliminación al botón
        row.querySelector('.delete-button').addEventListener('click', () => {
            row.remove(); // Elimina la fila de la tabla
            updateTotal();
        });

        tableBody.appendChild(row);
    });

    updateTotal();
};

const populateSelect = async (selectId, module) =>  {
    const select = document.getElementById(selectId);
    const newSelect = select.outerHTML;
    select.outerHTML = newSelect;

    const newSelectElement = document.getElementById(selectId);
    newSelectElement.innerHTML = '';

    try {
        const options = await apiService.fetchData(`${urlBase}/${module}/mostrar`, 'GET');
        const defaultOption = new Option('Seleccionar', '');
        defaultOption.hidden = true;
        defaultOption.selected = true;
        newSelectElement.appendChild(defaultOption);

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

const populateInput = async (id, branch_id) => {
    const url = `${urlBase}/${currentModule}/filtrar`;

    try {
        const response = await apiService.fetchData(url, 'POST', { id,  branch_id});
        document.getElementById('addSalePrice').value = `Q${response.selling_price}` || '';
        document.getElementById('addStock').value = response.quantity || '';
    } catch (error) {
        console.error('Error:', error);
    }
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