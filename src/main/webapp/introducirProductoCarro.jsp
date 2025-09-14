<%@ page import="controlador.Controlador" %>
<%@ page import="models.Producto" %>
<%@ page import="models.Cliente" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 06/09/2025
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Su producto ha sido introducido</title>
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
        }%>
</header>
    <%
      if (usuario == null){
        response.sendRedirect("index.jsp");
        return;
      }else{
        int idProducto;
        try{
          idProducto = Integer.parseInt(request.getParameter("idProducto"));
        }catch (NumberFormatException e){
          session.setAttribute("error","Ha ocurrido un error al añadir el producto en el carro");
          response.sendRedirect("error.jsp");
          return;
        }
          if (usuario instanceof Cliente && controlador.addProductoCarrito((Cliente) usuario, idProducto)) {
              Producto producto = controlador.buscaProductoById(idProducto);%>
<div class="contenedor-confirmacion">
    <img src="<%=producto.getUrlImagen()%>">
    <h2><%=producto.getMarca()%> <%=producto.getModelo()%> ha sido añadido al carro correctamente</h2>
    <h3>Mira los productos que tienes añadidos en <a href="carrito.jsp">tu carro</a></h3>
</div>
<%
        }
    }%>
</body>
</html>
