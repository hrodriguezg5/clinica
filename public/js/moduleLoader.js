import { apiService } from './services/apiService.js';
import { updateUserInfo } from './utils/userInfo.js';
import { createMenu } from './utils/menu.js';
import { translateToEnglish } from './utils/translateModule.js';

export async function loadModule(module) {
    const url = `${urlBase}/${module}/token`;
    const token = localStorage.getItem('token');

    if (token) {
        const data = await apiService.fetchData(url, 'GET');

        if (data) {
            const hasAccess = data.modules.some(item => item.link === module);

            if (!hasAccess) {
                window.location.href = urlBase;
                return;
            }

            $('#spinner').removeClass('show');
            updateUserInfo(data);
            createMenu(data.modules, module, data);
            
            const moduleScript = await import(`./modules/${translateToEnglish(module)}.js`);
            moduleScript.initModule(data, module);
        } else {
            window.location.href = urlBase;
        }
    } else {
        window.location.href = urlBase;
    }
}