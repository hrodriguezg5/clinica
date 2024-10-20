export function translateToEnglish (spanishModule){
    const module = {
        'inicio': 'home',
        'usuario': 'user',
        'rol': 'role',
        'paciente': 'patient',
        'posicion': 'position'
    };

    return module[spanishModule] || spanishModule;
}