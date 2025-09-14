<%@ page import="controlador.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Pedido" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.PedidoClienteDataClass" %>
<%@ page import="comunicaciones.Comunicaciones" %><%--
  Created by IntelliJ IDEA.
  User: manol
  Date: 14/09/2025
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dando de baja trabajador...</title>
</head>
<body>
<%
        Object usuario;
        Controlador controlador;
        if (session.getAttribute("controlador") == null) {
            controlador = new Controlador();
            session.setAttribute("controlador", controlador);
        } else controlador = (Controlador) session.getAttribute("controlador");
        // Lógica para comprobar si hay un usuario logueado
        usuario = session.getAttribute("usuario");
        if (usuario instanceof Admin){
            int idTrabajador;
            try{
                idTrabajador = Integer.parseInt(request.getParameter("idTrabajador"));
            }catch (NumberFormatException e){
                response.sendRedirect("index.jsp");
                return;
            }
            Trabajador trabajadorAEliminar = controlador.buscaTrabajadorById(idTrabajador);
            if (trabajadorAEliminar.numPedidosPendientes() == 0 && controlador.borraTrabajador(trabajadorAEliminar)) {

                ArrayList<Pedido> pedidosSinAsignar = controlador.pedidosSinTrabajador();
                Trabajador candidato = controlador.buscaTrabajadorCandidatoParaAsignar();

                if (!pedidosSinAsignar.isEmpty() && candidato != null) {
                    for (Pedido p : pedidosSinAsignar) {
                        controlador.asignaPedido(p.getId(), candidato.getId());
                    }

                    for (Pedido pedido : controlador.getTodosPedidos()) {
                        for (PedidoClienteDataClass pDataClass : controlador.getPedidosAsignadosTrabajador(candidato.getId())) {
                            if (pedido.getId() == pDataClass.getIdPedido())
                                Comunicaciones.enviaCorreoPedidoAsignacion(candidato.getEmail(), "ASIGNACIÓN DE PEDIDOS", pDataClass);
                        }
                    }

                }
                response.sendRedirect("resumenTrabajadores.jsp");
            }else{
                session.setAttribute("error","Este trabajador no se puede eliminar");
                response.sendRedirect("error.jsp");
                return;
            }
        }else{
            response.sendRedirect("index.jsp");
            return;
        }
%>
</body>
</html>
