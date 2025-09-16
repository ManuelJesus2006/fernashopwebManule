<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 15/09/2025
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hacer o recuperar copia de seguridad</title>
    <link rel="stylesheet" href="css/menuBackup.css">
</head>
<body>
<%
        Object usuario;
        Controlador controlador;
        if (session.getAttribute("controlador") == null){
            controlador = new Controlador();
            session.setAttribute("controlador", controlador);
        }else controlador = (Controlador) session.getAttribute("controlador");
        // Lógica para comprobar si hay un usuario logueado
        usuario = session.getAttribute("usuario");
        if (usuario instanceof Admin){%>
<div class="backup-panel">
    <h2>¿Qué deseas hacer?</h2>
    <div class="backup-actions">
        <a href="procesarRealizaBackup.jsp"><button class="backup-button">Realizar un nuevo backup</button></a>
        <a href="procesarRecuperarBackup.jsp"><button class="backup-button recuperar">Recuperar último backup</button></a>
    </div>
    <a href="index.jsp">
        <button class="boton-inicio">Volver al inicio</button>
    </a>
    <p class="reminder"><b>Recordatorio: Tanto la creación como la recuperación del backup serán en el servidor principal en un directorio
        ABSOLUTO ÚNICO (debido por algunos problemas servidor/local que se tuvo durante el desarrollo)</b></p>
</div>
<%}else{
            response.sendRedirect("index.jsp");
            return;
}%>
</body>
</html>
