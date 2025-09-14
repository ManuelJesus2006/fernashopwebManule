<%@ page import="models.Cliente" %>
<%@ page import="DAO.DAOManager" %>
<%@ page import="DAO.DAOClienteSQL" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controlador.Controlador" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 04/09/2025
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Verificando tu cuenta...</title>
</head>
<body>
<h1>Validando su cuenta...</h1>
<%
  Controlador controlador;
  if (session.getAttribute("controlador") == null){
    controlador = new Controlador();
    session.setAttribute("controlador", controlador);
  }else controlador = (Controlador) session.getAttribute("controlador");
  DAOManager dao = DAOManager.getSinglentonInstance();
  String token = request.getParameter("token");
int idCliente = Integer.parseInt(request.getParameter("userId"));
DAOClienteSQL daoClienteSQL = new DAOClienteSQL();
  ArrayList<Cliente> todosClientes = daoClienteSQL.readAll(dao);
  Cliente cliente = null;
for (Cliente c : todosClientes){
  if (c.getId() == idCliente) cliente = c;
}
  if (cliente.isValid()){
    session.setAttribute("error", "Este usuario ya está verificado");
    response.sendRedirect("error.jsp");
    return;
  }else{
    controlador.compruebaToken(cliente, token);
    session.setAttribute("usuario",cliente);
    response.sendRedirect("index.jsp");
  }
%>

</body>
</html>
