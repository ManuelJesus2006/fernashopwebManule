/* Cuando el usuario hace clic en el botón, alterna la visibilidad del menú */
function mostrarMenu() {
    document.getElementById("miMenuDesplegable").classList.toggle("show");
}

/* Cierra el menú si el usuario hace clic fuera de él */
window.onclick = function(event) {
    if (!event.target.matches('.botonDesplegable')) {
        var dropdowns = document.getElementsByClassName("contenidoBotonDesplegable");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}