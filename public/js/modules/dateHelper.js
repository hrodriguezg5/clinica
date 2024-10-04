export const getCurrentDate = () => {
    const today = new Date();
    return today.toLocaleDateString('es-GT', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
    }).split('/').reverse().join('-');
};

export const validateDates = (startDate, endDate) => {
    if (startDate > endDate) {
        return startDate;
    } else if (endDate < startDate) {
        return endDate;
    }
    return null;
};