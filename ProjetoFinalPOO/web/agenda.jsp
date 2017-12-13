<%@page import="br.com.fatecpg.project.ConsultaMarcada"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }

   String crm = request.getParameter("idMedico");
   //String medico = request.getParameter("nmMedico");

%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Agenda</title>
  </head>
  <body>
    <h1>Agenda</h1>

    <table border="1">
      <tr>
        <th>Nome</th>
        <th>Hora</th>
        <th>Data</th>
        <th>Motivo</th>
        <th>Valor</th>
      </tr>
      <%try {%>
      <%for (ConsultaMarcada c : ConsultaMarcada.getConsultaMarcadaList()) {%>
      <tr>
        <td><%= c.getNome()%></td>
        <td><%= c.getHr()%></td>
        <td><%= c.getData()%></td>
        <td><%= c.getMotivo()%></td>
        <td><%= c.getValor()%></td>
      </tr>
      <%}%>
      <%} catch (Exception e) {%>
      <div style="color: red;"><%=e.getMessage()%></div>
      <%}%>
    </table>

  </body>
</html>
