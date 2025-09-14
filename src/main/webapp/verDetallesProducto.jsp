<%@ page import="models.Producto" %>
<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 05/09/2025
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object usuario;
    Controlador controlador;
    if (session.getAttribute("controlador") == null){
        controlador = new Controlador();
        session.setAttribute("controlador", controlador);
    }else controlador = (Controlador) session.getAttribute("controlador");
    int idProducto;
    try{
        idProducto = Integer.parseInt(request.getParameter("productoID"));
    }catch (Exception e){
        response.sendRedirect("index.jsp");
        return;
    }
    Producto producto = controlador.buscaProductoById(idProducto);%>
<html>
<head>
    <title><%=producto.getMarca()%> <%=producto.getModelo()%></title>
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/detallesProducto.css">
    <script src="js/desplegableUser.js"></script>
</head>
<body>
<header class="header-container">
    <a href="index.jsp"><h1 class="tituloPrincipal">FERNANSHOP</h1></a>

    <div class="userlogueado">
        <%

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
                <a href="pedidosAsignados.jsp">Pedidos terminados</a>
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
                <a href="pedidosAdmin.jsp">Pedidos de clientes</a> <!--Aquí podrá ver todos los pedidos y cambiar el estado de alguno en concreto-->
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
</header>
<div class="tarjeta-producto">
    <div class="detalles-producto">
        <div class="imagen-container">
            <%if (producto.getRelevancia() > 9){%>
            <h3 class="oferta-especial">OFERTA ESPECIAL</h3>
            <%}%>
            <img src="<%=producto.getUrlImagen()%>">
        </div>

        <div class="info-principal">
            <h3><%=producto.getMarca()%> <%=producto.getModelo()%></h3>
            <h2><%=producto.getPrecio()%>€</h2>
            <h3>Descripción del producto:</h3>
            <p class="descripcion-producto"><%=producto.getDescripcion()%></p>

            <div class="botones-accion">
                <%if (usuario == null){%>
                <a href="login.jsp"><button>Iniciar sesión para comprar</button></a>
                <%}else if (usuario instanceof Cliente){%>
                <form action="introducirProductoCarro.jsp" method="post">
                    <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
                    <button type="submit">Añadir al carrito</button>
                </form>
                <%}else if (usuario instanceof Trabajador || usuario instanceof Admin){%>
                <form action="modificarProducto.jsp" method="post">
                    <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
                    <button type="submit">Modificar producto</button>
                </form>
                <%}%>
            </div>
        </div>
    </div>
</div>
</body>
</html>
