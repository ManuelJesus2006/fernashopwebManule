<%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 01/09/2025
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Iniciar sesion - FERNANSHOP</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="js/botonOcultarMostrarClave.js"></script>
</head>
<body>
<header>
    <h1 class="tituloPrincipal">FERNANSHOP</h1>
</header>
<h2>Productos de calidad, solo aquí en FERNANSHOP</h2>
<br>
<br>
<div class="form-card">
    <form action="procesarLogin.jsp" method="post">
        <div>
            <input type="text" name="correo" placeholder="Introduce tu correo" required>
        </div>
        <div class="password-container">
            <input type="password" name="pass" placeholder="Introduce tu contraseña" required>
            <button type="button" id="togglePasswordButton" onclick="togglePasswordVisibility()">Mostrar contraseña</button>
        </div>
        <button type="submit">Iniciar sesión</button>
    </form>
    <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate</a></p>
</div>
<div class="back-button-container">
    <a href="index.jsp" class="back-button">Volver al inicio</a>
</div>
</body>
</html>