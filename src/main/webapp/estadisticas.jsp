<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 13/09/2025
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Estadísticas de la app</title>
  <link rel="stylesheet" href="css/general.css">
  <link rel="stylesheet" href="css/estadisticas.css">
  <script src="js/desplegableUser.js"></script>
</head>
<body>
<header class="header-container">
  <a href="index.jsp"><h1 class="tituloPrincipal">FERNANSHOP</h1></a>

  <div class="userlogueado">
    <%
      int numPedidosSinTrabajador;
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
      numPedidosSinTrabajador = controlador.numPedidosSinTrabajador();
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
<%ArrayList<Trabajador> trabajadores = controlador.getTrabajadores();%>
<div class="panel-estadisticas">
  <h3>Nº de clientes: <%=controlador.getClientes().size()%></h3>
  <h3>Nº de trabajadores: <%=trabajadores.size()%></h3>
  <h3>Nº de pedidos: <%=controlador.getTodosPedidos().size()%></h3>
  <h3>Nº de pedidos pedientes: <%=controlador.numPedidosPendientes(trabajadores)%></h3>
  <h3>Nº de pedidos completados o cancelados: <%=controlador.numPedidosCompletadosCancelados(trabajadores)%></h3>
  <h3>Nº de pedidos sin asignar: <%=numPedidosSinTrabajador%></h3>
</div>
<a href="index.jsp" class="boton-inicio">Volver al inicio</a>
</body>
</html>
