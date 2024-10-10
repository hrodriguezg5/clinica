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
                return await response.json();
            }
        } catch (error) {
            console.error('Error:', error);
            throw error;
        }
    }
};