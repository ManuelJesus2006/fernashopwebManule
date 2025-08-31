<%@ page import="java.util.Properties" %>
<%@ page import="persistencia.Persistencia" %>
<%@ page import="DAO.DAOProductoSQL" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Producto" %>
<%@ page import="DAO.DAOManager" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FERNANSHOPWEB</title>
    <link rel="stylesheet" href="css/general.css">
</head>
<body>
<header class="header-container">
    <h1 class="tituloPrincipal">FERNANSHOP</h1>

    <div class="userlogueado">
        <%
            // Lógica para comprobar si hay un usuario logueado
            String username = (String) session.getAttribute("username");
            if (username != null) {
        %>
        <span class="userSiLogueado">¡Hola, <%= username %>!</span>
        <a href="logout.jsp" class="login-button">Cerrar Sesión</a>
        <%
        } else {
        %>
        <a href="login.jsp" class="login-button">Iniciar Sesión</a>
        <%
            }
        %>
        <div class="cart-container">
            <a href="cart.jsp">Mi Carro</a>
        </div>
    </div>

</header>
<%
    if (Persistencia.accesoInvitado()) {%>
<div class="contenedor-de-productos">
    <%DAOManager dao = DAOManager.getSinglentonInstance();
        DAOProductoSQL daoProducto = new DAOProductoSQL();
        ArrayList<Producto> todosLosProductos = daoProducto.readAll(dao);
        for (Producto p : todosLosProductos) {
    %>
    <div class="producto-style">
        <%String modeloProducto = p.getModelo();%>
        <h4><%=modeloProducto%></h4>
        <img src="<%=p.getUrlImagen(modeloProducto)%>">
        <a href="verDetallesProducto.jsp"><button>VER DETALLES PRODUCTO</button></a>
        <h3><%=p.getPrecio()%>€</h3>
    </div>
    <%
            }
        }
    %>
</div>

</body>
</html>