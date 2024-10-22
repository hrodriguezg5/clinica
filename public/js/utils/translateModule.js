export function translateToEnglish (spanishModule){
    const module = {
        'inicio': 'home',
        'usuario': 'user',
        'rol': 'role',
        'paciente': 'patient',
        'empleado': 'employee',
        'posicion': 'position',
        'proveedor': 'supplier',
    };

    return module[spanishModule] || spanishModule;
}