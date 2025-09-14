<%@ page import="controlador.Controlador" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %>
<%@ page import="models.PedidoClienteDataClass" %>
<%@ page import="models.Pedido" %>
<%@ page import="utils.Utils" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 09/09/2025
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestión del pedido</title>
    <link rel="stylesheet" href="css/gestionarPedido.css">
</head>
<body>
<%
    Object usuario;
    Controlador controlador;
    if (session.getAttribute("controlador") == null){
      controlador = new Controlador();
      session.setAttribute("controlador", controlador);
    }else controlador = (Controlador) session.getAttribute("controlador");
    // Lógica para comprobar si hay un usuario logueado
    usuario = session.getAttribute("usuario");

  int posPedidoAGestionar;
  try{
      posPedidoAGestionar = Integer.parseInt(request.getParameter("posArrayListPedidoAsignado"));
  }catch (NumberFormatException e){
      response.sendRedirect("index.jsp");
      return;
  }
    if (usuario instanceof Trabajador){
        PedidoClienteDataClass pedidoTrabajadorAGestionar = controlador.getPedidosAsignadosTrabajador(((Trabajador) usuario).getId()).get(posPedidoAGestionar - 1);
        int idPedidoTrabajador = pedidoTrabajadorAGestionar.getIdPedido();
%>
<h3>Pedido nº<%=idPedidoTrabajador%></h3>
<form action="procesarCambioEstadoPedido.jsp" method="post">
    <select name="estado">
        <option value="1">1 (En preparación)</option>
        <option value="2">2 (Enviado)</option>
        <option value="3">3 (Cancelado)</option>
    </select>
    <input type="text" name="comentario" value="<%=pedidoTrabajadorAGestionar.getComentario()%>">
    <input type="date" name="fechaEntrega" value="<%=pedidoTrabajadorAGestionar.getFechaEntregaEstimada()%>">
    <input type="hidden" name="idPedido" value="<%=idPedidoTrabajador%>">
    <div class="button-container">
        <button type="submit">Actualizar pedido</button>
        <a href="pedidosAsignados.jsp" class="cancel-button">Cancelar cambio estado</a>
    </div>
</form>
    <%} else if (usuario instanceof Admin){
        Pedido pedidoAdminAGestionar = controlador.getTodosPedidosSinGestionar().get(posPedidoAGestionar - 1);
        int idPedidoAdmin = pedidoAdminAGestionar.getId();
    %>
<h3>Pedido nº<%=pedidoAdminAGestionar.getId()%></h3>
<form action="procesarCambioEstadoPedido.jsp" method="post">
    <select name="estado">
        <option value="1">1 (En preparación)</option>
        <option value="2">2 (Enviado)</option>
        <option value="3">3 (Cancelado)</option>
    </select>
    <input type="text" name="comentario" value="<%=pedidoAdminAGestionar.getComentario()%>">
    <input type="date" name="fechaEntrega" value="<%=pedidoAdminAGestionar.getFechaEntregaEstimada()%>">
    <input type="hidden" name="idPedido" value="<%=idPedidoAdmin%>">
    <div class="button-container">
        <button type="submit">Actualizar pedido</button>
        <a href="pedidosAsignados.jsp" class="cancel-button">Cancelar cambio estado</a>
    </div>
</form>
    <%}else{
  response.sendRedirect("index.jsp");
  return;
  }
    %>
</body>
</html>
