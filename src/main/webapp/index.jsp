<%@ page import="persistencia.Persistencia" %>
<%@ page import="DAO.DAOProductoSQL" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Producto" %>
<%@ page import="DAO.DAOManager" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %>
<%@ page import="controlador.Controlador" %>
<%@ page import="java.net.InetAddress" %>
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
    <a href="index.jsp"><h1 class="tituloPrincipal">FERNANSHOP</h1></a>

    <div class="userlogueado">
        <%
            System.out.println(InetAddress.getLocalHost().getHostAddress());
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
        } else if (usuario != null && usuario instanceof Trabajador) {%>
        <span class="userSiLogueado">¡Hola, <%= ((Trabajador) usuario).getNombre()%>!</span>
        <span class="userSiLogueado">Tienes <%= ((Trabajador) usuario).numPedidosPendientes()%> pedidos que gestionar</span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">⚙️</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="pedidosAsignados.jsp">Pedidos asignados</a>
                <a href="pedidosTerminados.jsp">Pedidos terminados</a>
                <a href="ver-modificarDatosPersonales.jsp">Ver mis datos y perfil</a>
                <a href="logout.jsp">Cerrar sesión</a>
            </div>
        </div>
        <%} else if (usuario != null && usuario instanceof Admin) {%>
        <span class="userSiLogueado">¡Hola, <%= ((Admin) usuario).getNombre()%>!</span>
        <%
            String mensaje = "";
            int numPedidosSinTrabajador = controlador.numPedidosSinTrabajador();
            if (numPedidosSinTrabajador == 0) mensaje = "No hay pedidos para asignar.";
            else if (numPedidosSinTrabajador == 1) {
                mensaje = "Tenemos " + numPedidosSinTrabajador + " pedido sin asignar. Debe asignarlos a un trabajador.";
            } else
                mensaje = "Tenemos " + numPedidosSinTrabajador + " pedidos sin asignar. Debe asignarlos a un trabajador.";
        %>
        <span class="userSiLogueado"><%=mensaje%></span>
        <div class="dropdown">
            <button onclick="mostrarMenu()" class="botonDesplegable">⚙️</button>
            <div id="miMenuDesplegable" class="contenidoBotonDesplegable">
                <a href="resumenClientes.jsp">Resumen de todos clientes</a>
                <a href="verPedidos.jsp">Resumen pedidos de clientes</a>
                <a href="resumenTrabajadores.jsp">Resumen de todos los trabajadores</a>
                <a href="estadisticas.jsp">Ver estadísticas</a>
                <a href="altaTrabajador.jsp">Dar de alta a un trabajador</a>
                <a href="bajaTrabajador.jsp">Dar de baja a un trabajador</a>
                <a href="asignarPedidoTrabajador.jsp">Asignar pedidos a trabajadores</a>
                <a href="mostrarConfiguracion.jsp">Mostrar configuración del programa</a>
                <a href="enviarListadoPedidosCorreo.jsp">Enviar listado de pedidos por correo</a>
                <a href="copiaSeguridad.jsp">Copia de seguridad</a>
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

</header> <!--Lógica mostrar catálogo-->
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
        <%String modeloProducto = p.getModelo();
        String URLImage = p.getUrlImagen();%>
        <h4><%=modeloProducto%>
        </h4>
        <img src="<%=p.getUrlImagen()%>">
        <form action="verDetallesProducto.jsp" method="post">
            <!--Para evitar que el usuario nos cambie los datos de los productos a la hora de ver el producto o hacer el pedido, usamos el ID del mismo-->
            <input type="hidden" name="productoID" value="<%=p.getId()%>">
            <button class="botonDetallesProducto" type="submit">VER DETALLES PRODUCTO</button>
        </form>

        <h3><%=p.getPrecio()%>€</h3>
        <%if (p.getRelevancia() > 9){%> <!--Mensaje si la relevancia en mayor a 9-->
        <h5>PROMO ESPECIAL</h5>
        <%}%>
    </div>
    <%
            }
        }else{%>
        <h1 class="error-guest-products">PARA VER NUESTROS PRODUCTOS, DEBE INICIAR SESIÓN</h1>
          <%  }%>
</div>
</body>
</html>