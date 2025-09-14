<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="comunicaciones.Comunicaciones" %>
<%@ page import="models.Pedido" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 07/09/2025
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pedido procesado</title>
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/confirmaciones.css">
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
            <a href="logout.jsp">Cerrar sesión</a>
        </div>
    </div>
    <a href="busquedaProductos.jsp"><button class="busquedaProducto">🔍︎</button></a>
    <div class="cart-container">
        <a href="carrito.jsp">Mi Carro</a>
    </div>
<%
        }else{
                response.sendRedirect("index.jsp");
                return;
        }%>
</header>
<%if (controlador.confirmaPedidoCliente(((Cliente) usuario).getId())){
    Pedido temp = ((Cliente) usuario).getPedidos().getLast();
    Comunicaciones.enviaCorreoPedidoCliente(((Cliente) usuario).getEmail(), "PEDIDO REALIZADO CON ÉXITO", temp);%>
<div class="contenedor-confirmacion">
    <h2>Tu pedido nº<%=temp.getId()%> ha sido realizado con éxito</h2>
    <h3>Mira todos tus pedidos realizados y su estado en <a href="verPedidos.jsp">ver mis pedidos</a></h3>
</div>
<%}else{
    session.setAttribute("error","Ha ocurrido un error al procesar tu pedido, sentimos las molestias");
    response.sendRedirect("error.jsp");
}%>
</body>
</html>
