function abrirPestania(evt, nombrePestania) {
    var i, contenidoPestania, botonPestania;
    contenidoPestania = document.getElementsByClassName("contenido-pestania");
    for (i = 0; i < contenidoPestania.length; i++) {
        contenidoPestania[i].style.display = "none";
    }
    botonPestania = document.getElementsByClassName("boton-pestania");
    for (i = 0; i < botonPestania.length; i++) {
        botonPestania[i].className = botonPestania[i].className.replace(" activo", "");
    }
    document.getElementById(nombrePestania).style.display = "block";
    evt.currentTarget.className += " activo";
}
document.addEventListener("DOMContentLoaded", function(event) {
    document.getElementById("Pendientes").style.display = "block";
});