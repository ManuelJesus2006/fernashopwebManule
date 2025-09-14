<%@ page import="controlador.Controlador" %>
<%@ page import="models.Producto" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 10/09/2025
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Object usuario;
        Controlador controlador;
        if (session.getAttribute("controlador") == null){
            controlador = new Controlador();
            session.setAttribute("controlador", controlador);
        }else controlador = (Controlador) session.getAttribute("controlador");
        // Lógica para comprobar si hay un usuario logueado
        usuario = session.getAttribute("usuario");
        int idProducto;
        try{
            idProducto = Integer.parseInt(request.getParameter("idProducto"));
        }catch (NumberFormatException e){
            response.sendRedirect("index.jsp");
            return;
        }
        Producto producto = controlador.buscaProductoById(idProducto);
    %>
    <title>Modificacion de producto: <%=producto.getModelo()%></title>
    <link rel="stylesheet" href="css/datosProducto.css">
</head>
<body>
    <%if (usuario instanceof Trabajador || usuario instanceof Admin){%>
    <h1>Modificación del producto <%=producto.getId()%></h1>
    <img src="<%=producto.getUrlImagen()%>">
    <h3>Marca: <%=producto.getMarca()%>
    </h3>
    <form action="cambioDatoProducto.jsp" method="post">
        <input type="hidden" name="tipo" value="marca">
        <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
        <button type="submit">Modificar marca</button>
    </form>
    <h3>Modelo: <%=producto.getModelo()%>
    </h3>
    <form action="cambioDatoProducto.jsp" method="post">
        <input type="hidden" name="tipo" value="modelo">
        <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
        <button type="submit">Modificar modelo</button>
    </form>
    <h3>Descripcion: <%=producto.getDescripcion()%>
    </h3>
    <form action="cambioDatoProducto.jsp" method="post">
        <input type="hidden" name="tipo" value="descripcion">
        <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
        <button type="submit">Modificar descripción</button>
    </form>
    <h3>Precio: <%=producto.getPrecio()%>€
    </h3>
    <form action="cambioDatoProducto.jsp" method="post">
        <input type="hidden" name="tipo" value="precio">
        <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
        <button type="submit">Modificar precio</button>
    </form>
<%}%>
</body>
</html>
