<%@ page import="DAO.DAOManager" %>
<%@ page import="controlador.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Admin" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 01/09/2025
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Iniciando sesion...</title>
</head>
<body>
    <%
      Controlador controlador = (Controlador) session.getAttribute("controlador");
      Object usuario = session.getAttribute("usuario");
      if (usuario != null) {
        response.sendRedirect("index.jsp");
        return;
      }
      DAOManager dao = null;
      String correo = request.getParameter("correo");
      String clave = request.getParameter("pass");
      try {
        dao = DAOManager.getSinglentonInstance();
        dao.open();
      } catch (Exception e) {
        session.setAttribute("error", "Fallo al conectar a la Base de Datos");
        response.sendRedirect("error.jsp");
        return;
      }
      Object user = controlador.login(correo, clave);
      /*Cliente cliente;
      Trabajador trabajador;
      Admin admin;
      if (user instanceof Cliente) cliente = (Cliente) user;
      if (user instanceof Trabajador) cliente = (Cliente) user;
      if (user instanceof C) cliente = (Cliente) user;*/
      if (user == null){
        session.setAttribute("error","Correo o contraseña incorrectos, vuelva a intentarlo");
        response.sendRedirect("error.jsp");
      } else if (user instanceof Cliente && !((Cliente) user).isValid()){
        session.setAttribute("error","Debes verificar tu cuenta, revisa tu correo electrónico");
        response.sendRedirect("error.jsp");
      } else{
        session.setAttribute("usuario",user);
        response.sendRedirect("index.jsp");
      }
    %>
</body>
</html>
