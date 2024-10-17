export const updateUserInfo = (data) => {
    const navUserName = document.getElementById('navUserName');
    const navRoleName = document.getElementById('navRoleName');
    const dropUserName = document.getElementById('dropUserName');

    navUserName.textContent = data.user_name;
    dropUserName.textContent = data.user_name;
    navRoleName.innerText = data.role_name;
};