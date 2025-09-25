<%@ page import="models.Admin" %>
<%@ page import="controlador.Controlador" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 14/09/2025
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trabajador dado de alta correctamente</title>
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
            if (session.getAttribute("controlador") == null) {
                controlador = new Controlador();
                session.setAttribute("controlador", controlador);
            } else controlador = (Controlador) session.getAttribute("controlador");
            // Lógica para comprobar si hay un usuario logueado
            usuario = session.getAttribute("usuario");
            if (usuario instanceof Admin) {%>

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
                <a href="logout.jsp" style="font-weight: bold; color: red">Cerrar sesión</a>
            </div>
        </div>
        <%
        } else {
            response.sendRedirect("index.jsp");
            return;
        }
        %>
    </div>
</header>
<%
    int telefono;
    try{
        telefono = Integer.parseInt(request.getParameter("telefono"));
    }catch (NumberFormatException e){
        response.sendRedirect("index.jsp");
        return;
    }
    String nombre = request.getParameter("nombre");
    String clave = request.getParameter("clave");
    String correo = request.getParameter("correo");
    if (controlador.nuevoTrabajador(correo, clave, nombre, telefono)){
        Trabajador trabajadorNuevoTemp = controlador.getTrabajadores().getLast();
%>
<div class="contenedor-confirmacion">
    <h2>El trabajador nº<%=trabajadorNuevoTemp.getId()%> ha sido añadido con éxito</h2>
    <h3>Mira todos tus trabajadores que tienes registrados en <a href="resumenTrabajadores.jsp">resumen de trabajadores</a></h3>
</div>
    <%}else{
        session.setAttribute("error","Ha ocurrido un error al crear el nuevo trabajador, sentimos las molestias");
        response.sendRedirect("error.jsp");
        return;
    }%>
</body>
</html>
