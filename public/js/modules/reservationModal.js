import { apiService } from './apiService.js';
import { refreshReservationTable } from './reservationTable.js';

// Función para obtener los datos del formulario
const getFormData = () => ({
    id: document.getElementById('upModReservationId').value,
    first_name: document.getElementById('upModFirstName').value,
    last_name: document.getElementById('upModLastName').value,
    email: document.getElementById('upModEmail').value,
    phone_number: document.getElementById('upModPhoneNumber').value,
    address: document.getElementById('upModAddress').value,
    product_id: document.getElementById('upModProduct').value,
    product_quantity: document.getElementById('upModProductQuantity').value,
    date: document.getElementById('upModDate').value,
    hour_id: document.getElementById('upModHour').value,
});

// Lógica del envío del formulario
document.getElementById('updateReservationForm').addEventListener('submit', async function(event) {
    event.preventDefault();
    const body = getFormData();
    const url = `${urlBase}/paciente/actualizar`;

    try {
        await apiService.fetchData(url, 'POST', body, 'json');
        // Cierra el modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('updateReservationModal'));
        modal.hide();

        // Refresca la tabla de reservaciones
        refreshReservationTable();
    } catch (error) {
        console.error('Error', error);
    }
});

// Función para actualizar la lista de horas en el modal
const updateReservationProductModal = async (product) => {
    const url = `${urlBase}/paciente/producto`;

    try {
        const data = await apiService.fetchData(url, 'POST', { product }, 'text');
        document.getElementById('upModProduct').innerHTML = data;
    } catch (error) {
        console.error('Error:', error);
    }
};

// Función para actualizar la lista de horas en el modal
const updateReservationHourModal = async (date, dateChange, hour) => {
    if (date !== dateChange) hour = '';
    const url = `${urlBase}/paciente/hora`;

    try {
        const data = await apiService.fetchData(url, 'POST', { date, hour }, 'text');
        document.getElementById('upModHour').innerHTML = data;
    } catch (error) {
        console.error('Error:', error);
    }
};

// Función para actualizar el modal con los datos de la reservación
export const updateReservationModal = async (id) => {
    const url = `${urlBase}/paciente/cliente`;

    try {
        const data = await apiService.fetchData(url, 'POST', { id }, 'json');

        document.getElementById('upModReservationId').value = id;
        document.getElementById('upModFirstName').value = data.first_name || '';
        document.getElementById('upModLastName').value = data.last_name || '';
        document.getElementById('upModEmail').value = data.email || '';
        document.getElementById('upModPhoneNumber').value = data.phone_number || '';
        document.getElementById('upModAddress').value = data.address || '';
        document.getElementById('upModProductQuantity').value = data.product_quantity || '';
        document.getElementById('upModDate').value = data.date || '';

        await updateReservationProductModal(data.product || '');
        await updateReservationHourModal(data.date || '', data.date || '', data.hour || '');

        // Escuchar cambios en el campo de fecha
        document.getElementById('upModDate').addEventListener('change', function () {
            updateReservationHourModal(this.value, data.date || '', data.hour || '');
        });
    } catch (error) {
        console.error('Error:', error);
    }
};

// Lógica del envío del formulario
document.getElementById('deleteReservationForm').addEventListener('submit', async function(event) {
    event.preventDefault();
    const id = document.getElementById('delModReservationId').value;
    const url = `${urlBase}/paciente/eliminar`;

    try {
        await apiService.fetchData(url, 'POST', { id }, 'json');
        // Cierra el modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('deleteReservationModal'));
        modal.hide();

        // Refresca la tabla de reservaciones
        refreshReservationTable();
    } catch (error) {
        console.error('Error', error);
    }
});

// Función para actualizar el modal con los datos de la reservación
export const deleteReservationModal = async (id) => {
    const url = `${urlBase}/paciente/cliente`;

    try {
        const data = await apiService.fetchData(url, 'POST', { id }, 'json');

        document.getElementById('delModReservationId').value = id;
        document.getElementById('delModFirstName').innerText = data.first_name || '';
        document.getElementById('delModLastName').innerText = data.last_name || '';
        document.getElementById('delModEmail').innerText = data.email || '';
        document.getElementById('delModPhoneNumber').innerText = data.phone_number || '';
        document.getElementById('delModAddress').innerText = data.address || '';
        document.getElementById('delModProduct').innerText = data.product || '';
        document.getElementById('delModProductQuantity').innerText = data.product_quantity || '';
        document.getElementById('delModHour').innerText = data.hour || '';
        document.getElementById('delModDate').innerText = data.date || '';
    } catch (error) {
        console.error('Error:', error);
    }
};