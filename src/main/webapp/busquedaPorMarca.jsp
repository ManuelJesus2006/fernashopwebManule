<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Producto" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 08/09/2025
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resultados de la busqueda por marca</title>
    <link rel="stylesheet" href="css/general.css">
    <script src="js/desplegableUser.js"></script>
</head>
<body>
<header class="header-container">
    <a href="index.jsp"><h1 class="tituloPrincipal">FERNANSHOP</h1></a>

    <div class="userlogueado">
        <%
            Object usuario;
            Controlador controlador;
            if (session.getAttribute("controlador") == null){
                controlador = new Controlador();
                session.setAttribute("controlador", controlador);
            }else controlador = (Controlador) session.getAttribute("controlador");
            // Lógica para comprobar si hay un usuario logueado
            usuario = session.getAttribute("usuario");
            if ((usuario != null && usuario instanceof Cliente) && ((Cliente) usuario).isValid()) {
        %>

        <span class="userSiLogueado">¡Hola, <%= ((Cliente) usuario).getNombre() %>!</span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">⚙️</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="verPedidos.jsp">Ver mis pedidos</a>
                <a href="ver-modificarDatosPersonales.jsp">Ver mis datos y perfil</a>
                <a href="logout.jsp" style="font-weight: bold; color: red">Cerrar sesión</a>
            </div>
        </div>
        <a href="busquedaProductos.jsp"><button class="busquedaProducto">🔍︎</button></a>
        <div class="cart-container">
            <a href="carrito.jsp">Mi Carro</a>
        </div>
        <%} else{
            response.sendRedirect("index.jsp");
            return;
        }%>
    </div>
</header>
<%
String marca = request.getParameter("marca");
if (marca == null){
    response.sendRedirect("index.jsp");
    return;
}else{
    ArrayList<Producto> productosEncontrados = controlador.buscaProductosByMarca(marca);
    if (productosEncontrados.isEmpty()){%>
<h2>No se encontraron resultados para la marca: "<%=marca%>"</h2>
<%}else{%>
<h2>Resultados para la marca: "<%=marca%>"</h2>
    <%for (Producto prod : productosEncontrados){%>
<div class="producto-style">
    <%String modeloProducto = prod.getModelo();%>
    <h4><%=modeloProducto%>
    </h4>
    <img src="<%=prod.getUrlImagen()%>">
    <form action="verDetallesProducto.jsp" method="post">
        <!--Para evitar que el usuario nos cambie los datos de los productos a la hora de ver el producto o hacer el pedido, usamos el ID del mismo-->
        <input type="hidden" name="productoID" value="<%=prod.getId()%>">
        <button class="botonDetallesProducto" type="submit">VER DETALLES PRODUCTO</button>
    </form>

    <h3><%=prod.getPrecio()%>€</h3>
    <%if (prod.getRelevancia() > 9){%> <!--Mensaje si la relevancia en mayor a 9-->
    <h5>PROMO ESPECIAL</h5>
    <%}%>
</div>
<%}
}
}%>
</body>
</html>
