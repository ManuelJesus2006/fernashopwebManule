<%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 03/09/2025
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cerrando sesión</title>
</head>
<body>
<%session.invalidate();
response.sendRedirect("index.jsp");%>
</body>
</html>
