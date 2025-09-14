<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Producto" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 12/09/2025
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
  Object usuario;
  Controlador controlador;
  if (session.getAttribute("controlador") == null){
    controlador = new Controlador();
    session.setAttribute("controlador", controlador);
  }else controlador = (Controlador) session.getAttribute("controlador");
  // Lógica para comprobar si hay un usuario logueado
  usuario = session.getAttribute("usuario");
    String tipoDeDatoACambiar = request.getParameter("tipo");
    if (tipoDeDatoACambiar == null || usuario == null || usuario instanceof Cliente){
      response.sendRedirect("index.jsp");
      return;
    }
  %>
  <title>Cambio de <%=tipoDeDatoACambiar%> de producto</title>
</head>
<body>
<%String articulo;
String nuevoa;
  if (tipoDeDatoACambiar.equalsIgnoreCase("marca") || tipoDeDatoACambiar.equalsIgnoreCase("descripcion")){
    articulo = "La";
    nuevoa = "nueva";
  }
else{
    articulo = "El";
    nuevoa = "nuevo";
  }
int idProducto;
try{
  idProducto = Integer.parseInt(request.getParameter("idProducto"));
}catch (NumberFormatException e){
  response.sendRedirect("index.jsp");
  return;
}
  Producto producto = controlador.buscaProductoById(idProducto);
%>
<h3><%=articulo%> <%=tipoDeDatoACambiar%> original del producto es: <%=producto.get(tipoDeDatoACambiar)%></h3>
<form action="procesarCambioDatoProducto.jsp" method="post">
  <input type="text" name="<%=tipoDeDatoACambiar%>" placeholder="Introduce <%=articulo.toLowerCase()%> <%=tipoDeDatoACambiar%> <%=nuevoa%>" required>
  <input type="hidden" name="tipo" value="<%=tipoDeDatoACambiar%>">
  <input type="hidden" name="idProducto" value="<%=producto.getId()%>">
  <button type="submit">Cambiar <%=tipoDeDatoACambiar%></button>
</form>
<a href="index.jsp" class="cancel-button">Cancelar y volver al inicio</a>
</body>
</html>
