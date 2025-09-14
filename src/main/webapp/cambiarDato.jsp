<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 05/09/2025
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%String tipoDeDatoACambiar = request.getParameter("tipo");
  Object usuario = session.getAttribute("usuario");
  if (tipoDeDatoACambiar == null || usuario == null){
    response.sendRedirect("index.jsp");
    return;
  }
  %>
    <title>Cambio de <%=tipoDeDatoACambiar%></title>
</head>
<body>
    <%if (usuario instanceof Cliente){%>
    <h3>Tu <%=tipoDeDatoACambiar%> original es: <%=((Cliente) usuario).get(tipoDeDatoACambiar)%></h3>
    <%}else if (usuario instanceof Trabajador){%>
    <h3>Tu <%=tipoDeDatoACambiar%> original es: <%=((Trabajador) usuario).get(tipoDeDatoACambiar)%></h3>
    <%}%>
    <form action="procesarCambioDato.jsp" method="post">
      <input type="text" name="<%=tipoDeDatoACambiar%>" placeholder="Introduce tu nuevo <%=tipoDeDatoACambiar%>" required>
      <input type="hidden" name="tipo" value="<%=tipoDeDatoACambiar%>">
      <button type="submit">Cambiar <%=tipoDeDatoACambiar%></button>
    </form>
    <a href="index.jsp"><button>Cancelar y volver al inicio</button></a>
</body>
</html>
