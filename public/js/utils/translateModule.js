export function translateToEnglish (spanishModule){
    const module = {
        'inicio': 'home',
        'rol': 'role',
        'paciente': 'patient'
    };

    return module[spanishModule] || spanishModule;
}