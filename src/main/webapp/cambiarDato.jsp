<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 05/09/2025
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String tipoDeDatoACambiar = request.getParameter("tipo");
        Object usuario = session.getAttribute("usuario");
        if (tipoDeDatoACambiar == null || usuario == null) {
            response.sendRedirect("index.jsp");
            return;
        }
    %>
    <title>Cambio de <%=tipoDeDatoACambiar%>
    </title>
    <link rel="stylesheet" href="css/cambioDatoPersona.css">
</head>
<body>
<div class="form-card">
    <%
        if (usuario instanceof Cliente) {
            if (!tipoDeDatoACambiar.equalsIgnoreCase("clave")) {
    %>
    <h3>Tu <%=tipoDeDatoACambiar%> original es: <%=((Cliente) usuario).get(tipoDeDatoACambiar)%>
    </h3>
    <%} else {%>
    <h3>Cambio de contraseña</h3>
    <%}%>
    <%
    } else if (usuario instanceof Trabajador) {
        if (!tipoDeDatoACambiar.equalsIgnoreCase("clave")) {
    %>
    <%}%>
    <h3>Tu <%=tipoDeDatoACambiar%> original es: <%=((Trabajador) usuario).get(tipoDeDatoACambiar)%>
    </h3>
    <%} else {%>
    <h3>Cambio de contraseña</h3>
    <%}%>
    <form action="procesarCambioDato.jsp" method="post">
        <%
            String nuevoa = "";
        if (tipoDeDatoACambiar.equalsIgnoreCase("clave") || tipoDeDatoACambiar.equalsIgnoreCase("localidad") ||
                tipoDeDatoACambiar.equalsIgnoreCase("provincia") || tipoDeDatoACambiar.equalsIgnoreCase("direccion")) nuevoa = "nueva";
        else nuevoa = "nuevo";%>
        <input type="text" name="<%=tipoDeDatoACambiar%>" placeholder="Introduce tu <%=nuevoa%> <%=tipoDeDatoACambiar%>"
               required>
        <input type="hidden" name="tipo" value="<%=tipoDeDatoACambiar%>">
        <button type="submit">Cambiar <%=tipoDeDatoACambiar%>
        </button>
    </form>
    <a href="index.jsp" class="cancelar-btn">Cancelar y volver al inicio</a>
</div>
</body>
</html>