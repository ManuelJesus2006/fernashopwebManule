<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 07/09/2025
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrando carro y cancelando...</title>
</head>
<body>
<%
  Object usuario;
  Controlador controlador;
  if (session.getAttribute("controlador") == null){
    controlador = new Controlador();
    session.setAttribute("controlador", controlador);
  }else controlador = (Controlador) session.getAttribute("controlador");

  usuario = session.getAttribute("usuario");

  if (usuario instanceof Cliente){
    if (controlador.cancelaPedidoCliente(((Cliente) usuario).getId())){
      response.sendRedirect("carrito.jsp");
    } else {
      session.setAttribute("error","Tu carro ya está vacío");
      response.sendRedirect("error.jsp");
    }
  } else {
    response.sendRedirect("index.jsp");
  }
%>
</body>
</html>
