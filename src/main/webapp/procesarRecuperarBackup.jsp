<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 15/09/2025
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Backup recuperado correctamente</title>
    <link rel="stylesheet" href="css/confirmaciones.css">
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
        if (controlador.recuperaBackup()) {%>
<div class="contenedor-confirmacion">
    <h2>Backup recuperado correctamente</h2>
    <h3>Ya puedes volver al <a href="index.jsp">inicio</a></h3>
</div>
<%
        } else {
            session.setAttribute("error", "Ha ocurrido un error al recuperar el backup");
            response.sendRedirect("error.jsp");
            return;
        }
    } else {
        response.sendRedirect("index.jsp");
        return;
    }
%>
</body>
</html>
