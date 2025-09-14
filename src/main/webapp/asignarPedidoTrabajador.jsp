<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="models.Trabajador" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Pedido" %>
<%@ page import="models.Producto" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 14/09/2025
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Elegir un pedido para asignar</title>
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
      if (usuario instanceof Admin) {
    %>
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
    <%
      } else {
        response.sendRedirect("index.jsp");
        return;
      }
    %>
  </div>
</header>
<%
  ArrayList<Trabajador> trabajadores = controlador.getTrabajadores();
  ArrayList<Pedido> pedidosSinAsignar = controlador.pedidosSinTrabajador();
  if (pedidosSinAsignar.isEmpty()){%>
<h2>No hay pedidos para asignar</h2>
<%}else if(trabajadores.isEmpty()){%>
<h2>No existen trabajadores</h2>
<%}else{%>
<h2>Pedidos disponibles para asignar:</h2>
<%for (Pedido p : pedidosSinAsignar){// Lógica para contar la cantidad de cada producto
  Map<Integer, Producto> productosUnicos = new HashMap<>();
  Map<Integer, Integer> cantidades = new HashMap<>();
  for (Producto prod : p.getProductos()){
    int idProducto = prod.getId();
    productosUnicos.put(idProducto, prod);
    cantidades.put(idProducto, cantidades.getOrDefault(idProducto, 0) + 1);
  }
  double subtotal = 0.0;
  String estado = p.devuelveEstado(p.getEstado());
%>
<div class="pedido">
  <h4>Pedido <%=p.getId()%> - Estado: <%=estado%></h4>
  <h4>Comentario: <%=p.getComentario()%></h4>
  <%
    // Iterar sobre los productos únicos para mostrar la cantidad y calcular el subtotal
    for (Integer id : productosUnicos.keySet()){
      Producto prod = productosUnicos.get(id);
      int cantidad = cantidades.get(id);
      double precioTotalProducto = prod.getPrecio() * cantidad;
      subtotal += precioTotalProducto;
  %>
  <div class="producto-pedido">
    <h4>- <%=prod.getMarca() + " " + prod.getModelo()%> -
      <span style="font-weight: bold; font-size: 1em;">x<%=cantidad%></span>
      <h3><%=String.format("%.2f", prod.getPrecio())%>€</h3></h4>
    <img src="<%=prod.getUrlImagen()%>">
  </div>
  <%
    }
  %>
  <h3>Fecha de realización: <%=Utils.formateaFecha(p.getFechaPedido())%></h3>
  <h3>Fecha de entrega estimada: <%=Utils.formateaFecha(p.getFechaEntregaEstimada())%></h3>
  <h2 class="subtotal">Subtotal: <%=String.format("%.2f", subtotal)%>€</h2>
  <form action="elegirTrabajadorAsignacion.jsp" method="post">
    <input type="hidden" name="idPedido" value="<%=p.getId()%>">
    <button type="submit">Elegir pedido</button>
  </form>
</div>
<%}
}%>
</body>
</html>
