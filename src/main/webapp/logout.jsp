<%@ page import="controlador.Controlador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 03/09/2025
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cerrando sesión</title>
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
    if (usuario == null){
        response.sendRedirect("index.jsp");
        return;
    }else{
        controlador.guardaCierreSesion(usuario);
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
    %>
</body>
</html>
