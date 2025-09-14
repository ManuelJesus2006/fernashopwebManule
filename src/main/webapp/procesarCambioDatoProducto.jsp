<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Producto" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 12/09/2025
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Procesando cambio de dato...</title>
    <link rel="stylesheet" href="css/confirmaciones.css">
</head>
<body>
<%
    Controlador controlador = (Controlador) session.getAttribute("controlador");
    Object usuario = session.getAttribute("usuario");
    String tipoDeDatoACambiar = request.getParameter("tipo");
    if (usuario == null || tipoDeDatoACambiar == null || usuario instanceof Cliente){
        response.sendRedirect("index.jsp");
        return;
    }
    int idProducto;
    try{
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
    }catch (NumberFormatException e){
        response.sendRedirect("index.jsp");
        return;
    }
    Producto temp = controlador.buscaProductoById(idProducto);
    controlador.editarDatoConcretoProducto(tipoDeDatoACambiar, request.getParameter(tipoDeDatoACambiar), temp);
    Producto productoCambiado = controlador.buscaProductoById(idProducto);
%>
<div class="contenedor-confirmacion">
    <img class="producto-style" src="<%=productoCambiado.getUrlImagen()%>">
    <h2>Los cambios han sido realizados</h2>
    <h3>Marca: <%=productoCambiado.getMarca()%></h3>
    <h3>Modelo: <%=productoCambiado.getModelo()%></h3>
    <h3>Descripcion: <%=productoCambiado.getDescripcion()%></h3>
    <h3>Precio: <%=productoCambiado.getPrecio()%>€</h3>
    <a href="index.jsp">Volver al inicio</a>
</div>
</body>
</html>
