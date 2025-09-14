<%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 18/07/2025
  Time: 19:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("error") == null){
    response.sendRedirect("index.jsp");
    return;
  }
  String error = session.getAttribute("error").toString();
%>
<html>
<head>
  <title>ERROR</title>
  <link rel="stylesheet" href="css/error.css">
</head>
<body>
<div class="contenedor-error">
  <h2>Ha ocurrido un error al realizar su petición</h2>
  <p>
    <%=error%>
  </p>
  <%if (error.equals("Correo o contraseña incorrectos, vuelva a intentarlo")){%>
  <a href="login.jsp"><button>Vuelva a intentarlo</button></a>
  <%}else{%>
  <a href="index.jsp"><button>Volver al inicio</button></a>
  <%}
    session.removeAttribute("error");%>
</div>
</body>
</html>
