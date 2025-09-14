<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Producto" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 08/09/2025
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Busqueda de productos</title>
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/busquedaProducto.css">
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
        <%} else{
                response.sendRedirect("index.jsp");
                return;
        }%>
    </div>
</header>
<div class="formulariosBusqueda">
    <form action="busquedaPorMarca.jsp" method="post">
        <input type="text" name="marca" placeholder="Introduce una marca" required>
        <button type="submit">Buscar</button>
    </form>
    <form action="busquedaPorModelo.jsp" method="post">
        <input type="text" name="modelo" placeholder="Introduce un modelo" required>
        <button type="submit">Buscar</button>
    </form>
    <form action="busquedaPorDescripcion.jsp" method="post">
        <input type="text" name="descripcion" placeholder="Introduce una descripción" required>
        <button type="submit">Buscar</button>
    </form>
    <form action="busquedaPorTermino.jsp" method="post">
        <input type="text" name="termino" placeholder="Introduce un término" required>
        <button type="submit">Buscar</button>
    </form>
    <form action="busquedaPorPrecio.jsp" method="post">
        <%
            float precioMax = -1;
            for (Producto prod : controlador.getCatalogo()){
                if (precioMax < prod.getPrecio()) precioMax = prod.getPrecio();
            }
            %>
        <input type="number" name="precioMin" placeholder="Introduce un precio mínimo" min="0" max="<%=precioMax%>" required>
        <input type="number" name="precioMax" placeholder="Introduce un precio máximo" min="0" max="<%=precioMax%>" required>
        <button type="submit">Buscar</button>
    </form>
</div>
</body>
</html>
