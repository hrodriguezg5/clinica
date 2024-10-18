export const apiService = {
    async fetchData(url, method, body = {}) {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(url, {
                method,
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                ...(method !== 'GET' && { body: JSON.stringify(body) }),
            });

            if (response.ok) {
                // Verifica si el Content-Type es JSON
                const contentType = response.headers.get('Content-Type');
                if (contentType && contentType.includes('application/json')) {
                    // Intenta convertir la respuesta a JSON
                    return await response.json();
                } else {
                    // Si la respuesta no es JSON, solo retorna el texto o la respuesta cruda
                    return await response.text(); // O simplemente retorna response si no necesitas texto
                }
            } else {
                // Si la respuesta no es exitosa, arroja un error
                throw new Error(`Error: ${response.status} - ${response.statusText}`);
            }
        } catch (error) {
            console.error('Error:', error);
            throw error;
        }
    }
};