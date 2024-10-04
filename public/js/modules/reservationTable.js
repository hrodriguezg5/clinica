import { apiService } from './apiService.js';
import { updateReservationModal, deleteReservationModal } from './reservationModal.js';

// Función para asignar eventos a los botones de la tabla
const assignEventListeners = () => {
    document.querySelectorAll('.btn-update-reservation').forEach(button => {
        button.addEventListener('click', () => updateReservationModal(button.value));
    });

    document.querySelectorAll('.btn-delete-reservation').forEach(button => {
        button.addEventListener('click', () => deleteReservationModal(button.value));
    });
};

// Función para actualizar la tabla de reservaciones
export const refreshReservationTable = async () => {
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;
    const dataTableBody = document.getElementById('dataTable').getElementsByTagName('tbody')[0];
    const url = `${urlBase}/paciente/reservacion`;

    try {
        const data = await apiService.fetchData(url, 'POST', { startDate, endDate }, 'text');
        dataTableBody.innerHTML = data;
        assignEventListeners();
    } catch (error) {
        console.error('Error al actualizar la tabla', error);
    }
};
