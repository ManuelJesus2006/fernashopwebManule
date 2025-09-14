<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrarse - FERNANSHOP</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="js/botonOcultarMostrarClave.js"></script>
</head>
<body>
<header>
    <h1 class="tituloPrincipal">FERNANSHOP</h1>
</header>
<h2>Crea tu cuenta en minutos, recibe productos de calidad :D</h2>
<div class="form-card">
    <h2>Formulario de registro</h2>
    <form action="procesarRegistro.jsp" method="post">
        <input type="email" name="correo" placeholder="Introduzca su correo electrónico">
        <div class="password-container">
            <input type="password" name="clave" placeholder="Introduce tu contraseña">
            <button type="button" id="togglePasswordButton" onclick="togglePasswordVisibility()">Mostrar contraseña</button>
        </div>
        <input type="text" name="nombre" placeholder="Introduce tu nombre" required>
        <input type="text" name="localidad" placeholder="Introduce tu localidad" required>
        <input type="text" name="provincia" placeholder="Introduce tu provincia" required>
        <input type="text" name="direccion" placeholder="Introduce tu dirección" required>
        <input type="text" maxlength="9" name="telefono" placeholder="Introduce tu número de telefono" required>
        <button type="submit">Registrarse</button>
    </form>
    <a href="index.jsp" class="back-button">Volver al inicio</a>
</div>
</body>
</html>