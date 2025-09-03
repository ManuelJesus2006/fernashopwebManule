<%@ page import="persistencia.Persistencia" %>
<%@ page import="DAO.DAOProductoSQL" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Producto" %>
<%@ page import="DAO.DAOManager" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %>
<%@ page import="controlador.Controlador" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FERNANSHOPWEB</title>
    <link rel="stylesheet" href="css/general.css">
    <script src="js/desplegableUser.js"></script>
</head>
<body>
<header class="header-container">
    <h1 class="tituloPrincipal">FERNANSHOP</h1>

    <div class="userlogueado">
        <%
            Controlador controlador = new Controlador();
            session.setAttribute("controlador", controlador);
            int numPedidosSinTrabajador = controlador.numPedidosSinTrabajador();
            String mensaje = "";
            // Lógica para comprobar si hay un usuario logueado
            Object usuario = session.getAttribute("usuario");
            if (usuario != null && usuario instanceof Cliente) {
        %>

        <span class="userSiLogueado">¡Hola, <%= ((Cliente) usuario).getNombre() %>!</span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">Opciones</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="verPedidos.jsp">Ver mis pedidos</a>
                <a href="ver-modificarDatosPersonales.jsp">Ver mis datos y perfil</a>
                <a href="logout.jsp">Cerrar sesión</a>
            </div>
        </div>
        <a href="busquedaProductos.jsp"><button class="busquedaProducto">Buscar un producto</button></a>
        <div class="cart-container">
            <a href="carrito.jsp">Mi Carro</a>
        </div>
        <%
        } else if (usuario != null && usuario instanceof Trabajador) {%>
        <span class="userSiLogueado">¡Hola, <%= ((Trabajador) usuario).getNombre()%>!</span>
        <span class="userSiLogueado">Tienes <%= ((Trabajador) usuario).numPedidosPendientes()%> pedidos que gestionar</span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">Opciones</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="pedidosAsignados.jsp">Pedidos asignados</a>
                <a href="pedidosAsignados.jsp">Pedidos terminados</a>
                <a href="ver-modificarDatosPersonales.jsp">Ver mis datos y perfil</a>
                <a href="logout.jsp">Cerrar sesión</a>
            </div>
        </div>
        <%} else if (usuario != null && usuario instanceof Admin) {%>
        <span class="userSiLogueado">¡Hola, <%= ((Admin) usuario).getNombre()%>!</span>
        <%
            if (numPedidosSinTrabajador == 0) mensaje = "No hay pedidos para asignar.";
            else if (numPedidosSinTrabajador == 1) {
                mensaje = "Tenemos " + numPedidosSinTrabajador + " pedido sin asignar. Debe asignarlos a un trabajador.";
            } else
                mensaje = "Tenemos " + numPedidosSinTrabajador + " pedidos sin asignar. Debe asignarlos a un trabajador.";
        %>
        <span class="userSiLogueado"><%=mensaje%>/span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">Opciones</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="pedidosAsignados.jsp">Pedidos asignados</a>
                <a href="pedidosAsignados.jsp">Pedidos terminados</a>
                <a href="ver-modificarDatosPersonales.jsp">Ver mis datos y perfil</a>
                <a href="logout.jsp">Cerrar sesión</a>
            </div>
        </div>
        <%}else {
        %>
        <a href="login.jsp" class="login-button">Iniciar Sesión</a>
        <%
            }
        %>
    </div>

</header>
<%
    if (Persistencia.accesoInvitado() || usuario != null) {%>
<div class="contenedor-de-productos">
    <%
        DAOManager dao = DAOManager.getSinglentonInstance();
        DAOProductoSQL daoProducto = new DAOProductoSQL();
        ArrayList<Producto> todosLosProductos = daoProducto.readAll(dao);
        for (Producto p : todosLosProductos) {
    %>
    <div class="producto-style">
        <%String modeloProducto = p.getModelo();%>
        <h4><%=modeloProducto%>
        </h4>
        <img src="<%=p.getUrlImagen(modeloProducto)%>">
        <form action="verDetallesProducto.jsp" method="post">
            <!--Para evitar que el usuario nos cambie los datos de los productos a la hora de ver el producto o hacer el pedido, usamos el ID del mismo-->
            <input type="hidden" name="productoID" value="<%=p.getId()%>">
            <button class="botonDetallesProducto" type="submit">VER DETALLES PRODUCTO</button>
        </form>

        <h3><%=p.getPrecio()%>€</h3>
    </div>
    <%
            }
        }else{%>
        <h1 class="error-guest-products">PARA VER NUESTROS PRODUCTOS, DEBE INICIAR SESIÓN</h1>
          <%  }%>

</div>

</body>
</html>