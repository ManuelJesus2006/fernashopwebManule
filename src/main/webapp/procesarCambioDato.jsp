<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %>
<%@ page import="comunicaciones.Comunicaciones" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 05/09/2025
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Controlador controlador = (Controlador) session.getAttribute("controlador");
    Object usuario = session.getAttribute("usuario");
    String tipoDeDatoACambiar = request.getParameter("tipo");
    if (usuario == null || tipoDeDatoACambiar == null){
        response.sendRedirect("index.jsp");
        return;
    }
    %>
    <title>Procesando cambio de dato...</title>
</head>
<body>
    <%if (usuario instanceof Cliente){
        controlador.modificarDatoConcretoCliente(tipoDeDatoACambiar, request.getParameter(tipoDeDatoACambiar), (Cliente) usuario);
        controlador.generaToken((Cliente) usuario);%>
    <h2>¡Hola, <%=((Cliente) usuario).getNombre()%>!</h2>
    <h3>Debes verificar tu cuenta de nuevo para poder acceder a nuestros servicios, haz click en el enlace del correo que te hemos enviado</h3>
    <h3>Puedes cerrar esta pestaña si lo deseas o volver al <a href="index.jsp">inicio</a></h3>
    <%}else if (usuario instanceof Trabajador){
        controlador.modificarDatoConcretoTrabajador(tipoDeDatoACambiar, request.getParameter(tipoDeDatoACambiar), (Trabajador) usuario);
        response.sendRedirect("ver-modificarDatosPersonales.jsp");
    }else{
        response.sendRedirect("index.jsp");
        return;
    }
    %>
</body>
</html>
