export function translateToEnglish (spanishModule){
    const module = {
        'inicio': 'home',
        'usuario': 'user',
        'rol': 'role',
        'paciente': 'patient',
        'empleado': 'employee',
        'posicion': 'position',
        'medicina': 'medicine',
        'proveedor': 'supplier',
        'lote': 'batch',
        'sucursal': 'branch',
        'habitacion': 'room',
        'venta': 'sale',
    };

    return module[spanishModule] || spanishModule;
}