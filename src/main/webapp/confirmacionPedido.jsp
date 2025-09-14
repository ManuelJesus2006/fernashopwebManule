<%@ page import="models.Cliente" %>
<%@ page import="utils.Utils" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 07/09/2025
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Confirmacion de pedido inminente</title>
</head>
<body>
    <%Object usuario = session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }else if (((Cliente) usuario).getCarro().isEmpty()){
        session.setAttribute("error","No has introducido nada en el carro");
        response.sendRedirect("error.jsp");
    }else{
    %>
    <h2>Estás a punto de pagar <%=((Cliente) usuario).precioCarroSinIva(Utils.IVA)%>€ por
        <%
            int numProductos = ((Cliente) usuario).getCarro().size();
            String textoProducto = (numProductos > 1) ? "productos" : "producto";
        %>
        <%=numProductos%> <%=textoProducto%></h2>
    <a href="procesarPedido.jsp"><button>Tramitar pedido</button></a>
    <a href="carrito.jsp"><button>Introducir más productos</button></a>
<%}%>
</body>
</html>
