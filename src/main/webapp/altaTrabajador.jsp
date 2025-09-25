<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dar de alta un trabajador</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="js/botonOcultarMostrarClave.js"></script>
</head>
<body>
<%
    Object usuario;
    Controlador controlador;
    if (session.getAttribute("controlador") == null) {
        controlador = new Controlador();
        session.setAttribute("controlador", controlador);
    } else controlador = (Controlador) session.getAttribute("controlador");
    // Lógica para comprobar si hay un usuario logueado
    usuario = session.getAttribute("usuario");
    if (usuario instanceof Admin) {
%>
<div class="form-card">
    <h2>Registro de nuevo trabajador</h2>
    <form action="procesarAltaTrabajador.jsp" method="post">
        <input type="text" name="nombre" placeholder="Introduce el nombre del nuevo trabajador" required>
        <div class="password-container">
            <input type="password" name="clave" placeholder="Introduce la clave del nuevo trabajador" required>
            <button type="button" id="togglePasswordButton" onclick="togglePasswordVisibility()">Mostrar contraseña
            </button>
        </div>
        <input type="text" name="correo" placeholder="Introduce el correo del nuevo trabajador" required>
        <input type="text" name="telefono" placeholder="Introduce el teléfono del nuevo trabajador" maxlength="9"
               required>
        <button type="submit">Dar de alta al trabajador</button>
    </form>
</div>
<div class="back-button-container">
    <a href="index.jsp">
        <button class="back-button">Cancelar y volver al inicio</button>
    </a>
</div>

<%
    } else {
        response.sendRedirect("index.jsp");
        return;
    }
%>
</body>
</html>