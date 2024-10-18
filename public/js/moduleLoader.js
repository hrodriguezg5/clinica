import { apiService } from './services/apiService.js';
import { updateUserInfo } from './utils/userInfo.js';
import { createMenu } from './utils/menu.js';
import { translateToEnglish } from './utils/translateModule.js';

export async function loadModule(module) {
    const url = `${urlBase}/login/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');

        if (data) {
            const hasAccess = data.modules.some(item => item.link === module);

            if (!hasAccess) {
                // Si el módulo no existe o el usuario no tiene acceso, buscar el primer módulo disponible
                const firstAccessibleModule = data.modules.length > 0 ? data.modules[0].link : null;

                if (firstAccessibleModule) {
                    // Redirigir al primer módulo disponible
                    window.location.href = `${urlBase}/${firstAccessibleModule}`;
                } else {
                    // Si no hay módulos disponibles, redirigir a la URL base
                    window.location.href = urlBase;
                }
                return;
            }

            $('#spinner').removeClass('show');
            updateUserInfo(data);
            createMenu(data.modules, module, data);
            
            const moduleScript = await import(`./modules/${translateToEnglish(module)}.js`);
            moduleScript.initModule(data, module);
        } else {
            localStorage.setItem('tokenExpired', 'true');
            window.location.href = urlBase;
        }
    } else {
        window.location.href = urlBase;
    }
}