function togglePasswordVisibility() {
    // Buscamos el campo de contraseña por nombre ('clave' o 'pass')
    const passwordInput = document.querySelector('input[name="clave"]') || document.querySelector('input[name="pass"]');
    const toggleButton = document.getElementById('togglePasswordButton');

    // Verificamos si se encontró el campo y si su tipo es 'password' o 'text'
    if (passwordInput && (passwordInput.type === 'password' || passwordInput.type === 'text')) {
        if (passwordInput.type === 'password') {
            // Lo cambiamos a 'text' para mostrar la contraseña
            passwordInput.type = 'text';
            toggleButton.textContent = 'Ocultar contraseña';
        } else {
            // Lo cambiamos a 'password' para ocultar la contraseña
            passwordInput.type = 'password';
            toggleButton.textContent = 'Mostrar contraseña';
        }
    }
}