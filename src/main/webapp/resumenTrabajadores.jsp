<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 13/09/2025
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Trabajadores registrados</title>
  <link rel="stylesheet" href="css/general.css">
  <link rel="stylesheet" href="css/styleDatosClienteTrabajador.css">
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
<div class="contenedor-registros">
  <%ArrayList<Trabajador> trabajadoresRegistrados = controlador.getTrabajadores();
    if (trabajadoresRegistrados.isEmpty()){%>
  <h2 class="no-registros">No se han registrado clientes</h2>
  <%}else{
    for (Trabajador t : trabajadoresRegistrados){%>
  <div class="tarjeta-registro">
    <h2>Trabajador nº<%=t.getId()%></h2>
    <h3>Nombre: <%=t.getNombre()%></h3>
    <h3>Correo: <%=t.getEmail()%></h3>
    <h3>Móvil: <%=t.getMovil()%></h3>
  </div>
  <%}
  }%>
</div>
<a href="index.jsp" class="boton-inicio"><button>Volver al inicio</button></a>
</body>
</html>
