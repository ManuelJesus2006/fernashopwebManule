<%@ page import="java.net.InetAddress" %>
<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Producto" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="utils.Utils" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 06/09/2025
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mi carro</title>
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/carro.css">
    <script src="js/desplegableUser.js"></script>
    <script src="js/avisoEliminacionProducto.js"></script>
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
        }else{
                response.sendRedirect("index.jsp");
                return;
        }%>
</header>
<%
    // Lógica para agrupar productos por cantidad
    Map<Integer, Producto> productosUnicos = new HashMap<>();
    Map<Integer, Integer> cantidades = new HashMap<>();

    for (Producto producto : ((Cliente) usuario).getCarro()) {
        int idProducto = producto.getId();
        productosUnicos.put(idProducto, producto);
        cantidades.put(idProducto, cantidades.getOrDefault(idProducto, 0) + 1);
    }
%>

<%-- Ahora iteramos sobre los productos únicos para mostrarlos --%>
<%
    for (Integer id : productosUnicos.keySet()) {
        Producto prod = productosUnicos.get(id);
%>
<div class="producto-carrito">
    <img src="<%=prod.getUrlImagen()%>" alt="Imagen de <%=prod.getMarca()%> <%=prod.getModelo()%>">
    <div class="info-producto">
        <h4><%=prod.getMarca()%> <%=prod.getModelo()%></h4>
        <h3><%=prod.getPrecio()%>€</h3>
    </div>
    <div class="cantidad-selector">
        <form action="actualizarCarrito.jsp" method="post">
            <input type="hidden" name="idProducto" value="<%=prod.getId()%>">
            <label for="cantidad-<%=prod.getId()%>">Cantidad:</label>
            <input
                    type="number"
                    id="cantidad-<%=prod.getId()%>"
                    name="cantidad"
                    value="<%=cantidades.get(prod.getId())%>"
                    min="0"
                    max="10"
                    oninput="toggleWarning(this)">
            <span id="aviso-<%=prod.getId()%>" style="display:none; font-size: 0.8em; color: #dc3545; margin-left: 10px;">
        Se eliminará el producto del carro
      </span>
            <button type="submit">Actualizar</button>
        </form>
    </div>
</div>
<%
    }
%>

<%-- Código para mostrar el total del carrito (opcional) --%>
<%if (((Cliente) usuario).getCarro().isEmpty()){%>
<div class="total-carrito">
    <h2>No has añadido ningún producto en el carro</h2>
</div>
<%}else{%>
<div class="total-carrito">
    <h2>Total del Carrito: <%=((Cliente) usuario).precioCarroSinIva(Utils.IVA)%>€</h2>
</div>
<div class="tramitar-pedido-container">
    <a href="confirmacionPedido.jsp"><button>Tramitar pedido</button></a>
</div>
<div class="tramitar-pedido-container">
    <a href="procesarCancelarPedidoCliente.jsp"><button>Borrar carro</button></a>
</div>
<%}%>
</body>
</html>
