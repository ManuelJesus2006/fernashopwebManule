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
%>
<html>
<head>
  <title>ERROR</title>
  <!--link rel="stylesheet" href="css/estiloPrincipal.css"-->
</head>
<body>
<h2>Ha ocurrido un error al realizar su petición</h2>
<p>
  <%=session.getAttribute("error")%>
</p>
<a href="login.jsp"><button>Vuelva a intentarlo</button></a>
</body>
</html>
