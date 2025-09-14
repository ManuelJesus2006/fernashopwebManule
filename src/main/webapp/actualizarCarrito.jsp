<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Producto" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 08/09/2025
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Actualizando carrito...</title>
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
    if (usuario instanceof Cliente){
      int idProducto;
      int cantidadProducto;
      try{
        idProducto = Integer.parseInt(request.getParameter("idProducto"));
        cantidadProducto = Integer.parseInt(request.getParameter("cantidad"));
      }catch (NumberFormatException e){
        session.setAttribute("error","Ha ocurrido un error al actualizar su producto");
        response.sendRedirect("error.jsp");
        return;
      }

      if (controlador.quitaProductoCarroClienteAll((Cliente) usuario, idProducto)){
        for (int i = 0; i < cantidadProducto; i++) {
          controlador.addProductoCarrito((Cliente)usuario,idProducto);
        }
      }else{
        session.setAttribute("error","Ha ocurrido un error al actualizar su producto");
        response.sendRedirect("error.jsp");
        return;
      }
      response.sendRedirect("carrito.jsp");
    }else{
      response.sendRedirect("index.jsp");
      return;
    }
%>
</body>
</html>
