import { getCurrentDate, validateDates } from './modules/dateHelper.js';
import { refreshReservationTable } from './modules/reservationTable.js';

document.addEventListener('DOMContentLoaded', () => {
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');

    // Función para establecer fechas iniciales por defecto
    const setDefaultDates = () => {
        const today = getCurrentDate();
        startDateInput.value = today;
        endDateInput.value = today;
    };

    // Función para manejar el cambio de fechas y actualizar la tabla
    const handleDateChange = () => {
        const validDate = validateDates(startDateInput.value, endDateInput.value);
        if (validDate) {
            endDateInput.value = validDate;
        }
        refreshReservationTable();
    };

    // Inicializar el formulario con fechas por defecto y cargar datos
    const init = () => {
        setDefaultDates();
        refreshReservationTable();
    };

    // Asignar eventos para cambios en las fechas
    startDateInput.addEventListener('change', handleDateChange);
    endDateInput.addEventListener('change', handleDateChange);

    // Iniciar el proceso
    init();
});

// Actualizar la tabla cuando la página se muestra (por ejemplo, al regresar con el botón atrás)
window.addEventListener('pageshow', () => {
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const validDate = validateDates(startDateInput.value, endDateInput.value);
    if (validDate) {
        endDateInput.value = validDate;
    }
    refreshReservationTable();
});
