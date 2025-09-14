<%@ page import="controlador.Controlador" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="utils.Utils" %>
<%@ page import="models.*" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 07/09/2025
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pedidos asignados</title>
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/mostrarPedidos.css">
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
            if (usuario != null && usuario instanceof Trabajador) {%>
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
        <%
        }else {
                response.sendRedirect("index.jsp");
                return;
            }%>
    </div>
</header>
<%
        ArrayList<PedidoClienteDataClass> pedidosAsignados = controlador.getPedidosAsignadosTrabajador(((Trabajador) usuario).getId());
        if (pedidosAsignados.isEmpty()) {
%>
<div class="avisos">
    <h2>No tienes pedidos asignados</h2>
    <a href="index.jsp">
        <button>Volver al inicio</button>
    </a>
</div>
<%
} else {
    int numPedido = 1;
    for (PedidoClienteDataClass p : pedidosAsignados) {
%>
<%
    // Lógica para contar la cantidad de cada producto
    Map<Integer, Producto> productosUnicos = new HashMap<>();
    Map<Integer, Integer> cantidades = new HashMap<>();
    for (Producto prod : p.getProductos()) {
        int idProducto = prod.getId();
        productosUnicos.put(idProducto, prod);
        cantidades.put(idProducto, cantidades.getOrDefault(idProducto, 0) + 1);
    }
%>
<div class="pedido">
    <%
        String estado;
        switch (p.getEstado()) {
            case 0 -> estado = "Creado";
            case 1 -> estado = "En preparación";
            case 2 -> estado = "Enviado";
            case 3 -> estado = "Cancelado";
            default -> estado = "";
        }
        ;
    %>
    <h4 class="numPedido">Pedido <%=p.getIdPedido()%>
    </h4>
    <h4>Estado: <%=estado%>
    </h4>
    <h4>Dirección: <%=p.getDireccion()%>
    </h4>
    <h4>Localidad: <%=p.getLocalidad()%>
    </h4>
    <h4>Provincia: <%=p.getProvincia()%>
    </h4>
    <h4>Telefono: <%=p.getMovil()%>
    </h4>
    <h4>Comentario: <%=p.getComentario()%>
    </h4>
    <%
        // Iterar sobre los productos únicos para mostrar la cantidad
        for (Integer id : productosUnicos.keySet()) {
            Producto prod = productosUnicos.get(id);
    %>
    <div class="producto-pedido">
        <h4>- <%=prod.getMarca() + " " + prod.getModelo()%> -
            <span style="font-weight: bold; font-size: 1em;">x<%=cantidades.get(id)%></span>
            <h3><%=prod.getPrecio()%>€</h3></h4>
        <img src="<%=prod.getUrlImagen()%>">
    </div>
    <%
        }
    %>
    <h3>Fecha de realización: <%=Utils.formateaFecha(p.getFechaPedido())%>
    </h3>
    <h3>Fecha de entrega estimada: <%=Utils.formateaFecha(p.getFechaEntregaEstimada())%>
    </h3>
    <form action="gestionarPedido.jsp" method="post">
        <input type="hidden" name="posArrayListPedidoAsignado" value="<%=numPedido%>">
        <button type="submit">Gestionar pedido</button>
    </form>
</div>
<%
            numPedido++;
        }
    }
%>
</body>
</html>
