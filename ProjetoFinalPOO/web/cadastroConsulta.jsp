<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.com.fatecpg.project.Consulta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath());
   }

   String crmMedico = request.getParameter("idMedico");
   String cpfPaciente = request.getParameter("idPaciente");
   if (crmMedico == "" || cpfPaciente == "") {
      response.sendRedirect(request.getContextPath());
   }

   String cadastroComplete = null;
   String cadastroErrorMessage = null;

   if (request.getParameter("cadastrar-consulta") != null) {

      String idMedico = request.getParameter("crm");
      String idPaciente = request.getParameter("cpf");
      String hora = request.getParameter("hora");

      SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
      Date data = new Date(formatter.parse(request.getParameter("data")).getTime());

      String motivo = request.getParameter("motivo");
      String valorS = request.getParameter("valor");

      double valor = Double.parseDouble(valorS);

      try {

         Consulta.addConsulta(idMedico, idPaciente, hora, data, motivo, valor);
         response.sendRedirect(request.getContextPath() + "/listaConsulta.jsp");
         cadastroComplete = "Consulta cadastrada com sucesso!";

      } catch (Exception e) {
         cadastroErrorMessage = e.getMessage();
      }
   }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Cadastro de Consultas</title>

    <link rel="stylesheet" type="text/css" href="css/custom.css">
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>
    <div class="container-fluid">
      <div align="left">
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
      </div>

      <center>
        <br><br>
        <h2>Cadastrar Consulta</h2>

        <%if (cadastroErrorMessage != null) {%>
        <div style="color: red;"><%=cadastroErrorMessage%></div>
        <%} else if (cadastroComplete != null) {%>
        <div style="color: blue;"><%=cadastroComplete%></div>
        <%}%>

        <form method="post" >
          <h6>CRM:</h6> <input type="text" name="crm" value=<%=crmMedico%> required /><br><br>
          <h6>CPF:</h6> <input class="cpf" type="text" name="cpf" value=<%=cpfPaciente%> required /><br><br>
          <h6>Hora da Consulta:</h6> <input class="hora" type="text" name="hora" required /><br><br>
          <h6>Data da Consulta:</h6> <input class="data" cpattern="^[0-3][0-9]\/[0-1][0-9]\/[0-2][0-9]{3}$" type="text" name="data" required /><br><br>
          <h6>Motivo:</h6> <textarea type="text" name="motivo" rows="4"></textarea><br><br>
          <h6>Valor:</h6> <input class="numero" type="text" name="valor" required /><br><br>
          <input type="submit" name="cadastrar-consulta" value="Cadastrar" type="button" class="btn btn-outline-dark"/>
        </form>

      </center>

    </div>
    <%@include file="WEB-INF/jspf/footer.jspf" %>

  </body>
</html>
