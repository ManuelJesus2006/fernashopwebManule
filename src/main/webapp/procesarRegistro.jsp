<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 04/09/2025
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Procesando registro...</title>
</head>
<body>
    <%
      Controlador controlador = (Controlador) session.getAttribute("controlador");
      Object usuario = session.getAttribute("usuario");
    if (usuario != null) {
        response.sendRedirect("index.jsp");
        return;
    }else{
      String correo = request.getParameter("correo");
      String clave = request.getParameter("clave");
      String nombre = request.getParameter("nombre");
      String localidad = request.getParameter("localidad");
      String provincia = request.getParameter("provincia");
      String direccion = request.getParameter("direccion");
      int telefono = Integer.parseInt(request.getParameter("telefono"));
      Cliente cliente = controlador.nuevoCliente(correo, clave, nombre, localidad, provincia, direccion, telefono);
      if (cliente != null){
        controlador.generaToken(cliente);
      %>
    <h2>¡Hola, <%=cliente.getNombre()%>!</h2>
    <h3>Debes verificar tu cuenta para poder acceder a nuestros servicios, haz click en el enlace del correo que te hemos enviado</h3>
    <h3>Puedes cerrar esta pestaña si lo deseas o volver al <a href="index.jsp">inicio</a></h3>
    <%}else{
          session.setAttribute("error", "Ha ocurrido un error al registrarse, sentimos las molestias");
          response.sendRedirect("error.jsp");
      }
    }
    %>
</body>
</html>
