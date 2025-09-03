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
    <title>Iniciar sesion - FERNANSHOPWEB</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<header>
    <h1 class="tituloPrincipal">FERNANSHOP</h1>
</header>
<h2>Productos de calidad, solo aquí en FERNANSHOP</h2>
<br>
<br>
<form action="procesarLogin.jsp" method="post">
    <div>
        <input type="text" name="correo" placeholder="Introduce tu correo" required>
    </div>
    <div>
        <input type="password" name="pass" placeholder="Introduce tu contraseña" required>
    </div>
    <button type="submit">Iniciar sesión</button>
</form>
<p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate</a></p>
</body>
</html>
