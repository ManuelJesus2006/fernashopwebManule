<%@ page import="controlador.Controlador" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Admin" %>
<%@ page import="org.apache.commons.compress.archivers.tar.TarArchiveEntry" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 05/09/2025
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Perfil</title>
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
            if (session.getAttribute("controlador") == null) {
                controlador = new Controlador();
                session.setAttribute("controlador", controlador);
            } else controlador = (Controlador) session.getAttribute("controlador");
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
        <a href="busquedaProductos.jsp">
            <button class="busquedaProducto">🔍︎</button>
        </a>
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
                <a href="pedidosAdmin.jsp">Pedidos de clientes</a>
                <!--Aquí podrá ver todos los pedidos y cambiar el estado de alguno en concreto-->
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
<%
    if (usuario instanceof Cliente) {
        String nombre = ((Cliente) usuario).getNombre();
        String email = ((Cliente) usuario).getEmail();
        String clave = ((Cliente) usuario).getClave();
        String localidad = ((Cliente) usuario).getLocalidad();
        String provincia = ((Cliente) usuario).getProvincia();
        String direccion = ((Cliente) usuario).getDireccion();
        int numTelefono = ((Cliente) usuario).getMovil();
%>
<h3>Nombre de usuario: <%=nombre%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="nombre">
    <button type="submit">Cambiar</button>
</form>
<h3>Email: <%=email%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="email">
    <button type="submit">Cambiar</button>
</form>
<h3>Email: <%=clave%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="clave">
    <button type="submit">Cambiar</button>
</form>
<h3>Localidad: <%=localidad%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="localidad">
    <button type="submit">Cambiar</button>
</form>
<h3>Provincia: <%=provincia%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="provincia">
    <button type="submit">Cambiar</button>
</form>
<h3>Dirección: <%=direccion%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="direccion">
    <button type="submit">Cambiar</button>
</form>
<h3>Numero de teléfono: <%=numTelefono%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="telefono">
    <button type="submit">Cambiar</button>
</form>
<%
} else if (usuario instanceof Trabajador) {
    String nombre = ((Trabajador) usuario).getNombre();
    String email = ((Trabajador) usuario).getEmail();
    String clave = ((Trabajador) usuario).getPass();
    int numTelefono = ((Trabajador) usuario).getMovil();
%>
<h3>Nombre de usuario: <%=nombre%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="nombre">
    <button type="submit">Cambiar</button>
</form>
<h3>Email: <%=email%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="email">
    <button type="submit">Cambiar</button>
</form>
<h3>Contraseña: <%=clave%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="clave">
    <button type="submit">Cambiar</button>
</form>
<h3>Numero de teléfono: <%=numTelefono%>
</h3>
<form action="cambiarDato.jsp" method="post">
    <input type="hidden" name="tipo" value="telefono">
    <button type="submit">Cambiar</button>
</form>
<%
    } else {
        response.sendRedirect("index.jsp");
        return;
    }
%>

</body>
</html>
