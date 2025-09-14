<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 14/09/2025
  Time: 13:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
    Object usuario;
    Controlador controlador;
    if (session.getAttribute("controlador") == null) {
        controlador = new Controlador();
        session.setAttribute("controlador", controlador);
    } else controlador = (Controlador) session.getAttribute("controlador");
    // Lógica para comprobar si hay un usuario logueado
    usuario = session.getAttribute("usuario");
    if (usuario == null){
        response.sendRedirect("index.jsp");
        return;
    }else if(usuario instanceof Admin){
        int idTrabajador;
        try{
            idTrabajador = Integer.parseInt(request.getParameter("idTrabajador"));
        }catch (NumberFormatException e){
            response.sendRedirect("index.jsp");
            return;
        }
        Trabajador trabajador = controlador.buscaTrabajadorById(idTrabajador);
%>
    <title>¿Dar de baja a trabajador nº<%=idTrabajador%></title>
</head>
<body>
<h2>Esta a punto de dar de baja al trabajador nº<%=idTrabajador%>:</h2>
<h3>Nombre: <%=trabajador.getNombre()%></h3>
<h3>Correo: <%=trabajador.getEmail()%></h3>
<h3>Móvil: <%=trabajador.getMovil()%></h3>
<h4>¿Desea continuar?</h4>
<form action="procesarBajaTrabajador.jsp" method="post">
    <input type="hidden" name="idTrabajador" value="<%=trabajador.getId()%>">
    <button type="submit">Si, dar de baja</button>
</form>
<a href="index.jsp"><button>No, volver al inicio</button></a>
<%}else{
        response.sendRedirect("index.jsp");
        return;
}%>
</body>
</html>
