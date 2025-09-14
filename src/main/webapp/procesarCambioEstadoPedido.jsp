<%@ page import="controlador.Controlador" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 10/09/2025
  Time: 13:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cambiando estado...</title>
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
    if (usuario == null){
      response.sendRedirect("index.jsp");
      return;
    }else{
      int idPedido;
      int estado;
      LocalDate fechaEntrega;
      try{
        estado = Integer.parseInt(request.getParameter("estado"));
        idPedido = Integer.parseInt(request.getParameter("idPedido"));
        fechaEntrega = LocalDate.parse(request.getParameter("fechaEntrega"));
      }catch (Exception e){
        response.sendRedirect("index.jsp");
        return;
      }
      String comentario = request.getParameter("comentario");

      controlador.cambiaEstadoPedido(idPedido, estado);
      if (comentario != null) controlador.cambiaComentarioPedido(idPedido, comentario);
      controlador.cambiaFechaEntregaPedido(idPedido, fechaEntrega);
      response.sendRedirect("pedidosAsignados.jsp");
    }
%>
</body>
</html>
