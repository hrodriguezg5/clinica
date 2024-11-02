export function translateToEnglish (spanishModule){
    const module = {
        'inicio': 'home',
        'usuario': 'user',
        'rol': 'role',
        'paciente': 'patient',
        'diagnostico': 'diagnosis',
        'habitacion': 'room',
        'empleado': 'employee',
        'posicion': 'position',
        'medicina': 'medicine',
        'proveedor': 'supplier',
        'lote': 'batch',
        'sucursal': 'branch',
        'venta': 'sale',
        'examen': 'exam',
    };

    return module[spanishModule] || spanishModule;
}