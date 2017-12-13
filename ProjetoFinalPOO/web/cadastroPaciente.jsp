<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.com.fatecpg.project.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath());
   }
   String cadastroComplete = null;
   String cadastroErrorMessage = null;
   if (request.getParameter("cadastrar-paciente") != null) {

      String cpf = request.getParameter("cpf");
      String nome = request.getParameter("nome");
      String rg = request.getParameter("rg");
      String email = request.getParameter("email");
      String endereco = request.getParameter("endereco");
      String cidade = request.getParameter("cidade");
      String estado = request.getParameter("estado");
      String sexo = request.getParameter("sexo");
      String telefone = request.getParameter("telefone");

      SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
      Date nascimento = new Date(formatter.parse(request.getParameter("nascimento")).getTime());

      try {
         Paciente.addPaciente(cpf, nome, rg, email, endereco, cidade, estado, sexo, telefone, nascimento);
         response.sendRedirect(request.getRequestURI());
         cadastroComplete = "Paciente cadastrado com sucesso!";
      } catch (Exception e) {
         cadastroErrorMessage = e.getMessage();
      }
   }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Cadastro de Pacientes</title>
  </head>
  <body>
    <%@include file="WEB-INF/jspf/header.jspf" %>
    <div class="container-fluid">
      <center>
        <br><br>
        <h2 style='font-style:italic'>Cadastrar de Paciente</h2><br>
      </center>

      <%if (cadastroErrorMessage != null) {%>
      <div style="color: red;"><%=cadastroErrorMessage%></div>
      <%}%>
      <center>
        <form action="listaPaciente.jsp">
          <h6 style='font-style:italic'>CPF: </h6> <input type="text" maxlength="11" pattern="[0-9]+$" name="cpf" max required/><br><br>
          <h6 style='font-style:italic'>Nome:</h6> <input type="text" maxlength="100" name="nome" required/><br><br>
          <h6 style='font-style:italic'> Rg: </h6><input type="text" maxlength="9" pattern="[0-9]+$" name="rg" required/><br><br>
          <h6 style='font-style:italic'>Email:</h6> <input type="email" maxlength="100" name="email" required/><br><br>
          <h6 style='font-style:italic'>Endereco:</h6> <input type="text" maxlength="100" name="endereco" required/><br><br>
          <h6 style='font-style:italic'> Cidade:</h6> <input type="text" maxlength="100" name="cidade" required/><br><br>
          <h6 style='font-style:italic'>Estado: </h6><input type="text" maxlength="100" name="estado" required/><br><br>
          <h6 style='font-style:italic'>Sexo: </h6><input type="text" maxlength="30" name="sexo" required/><br><br>
          <h6 style='font-style:italic'>Telefone: </h6><input type="text" maxlength="15" name="telefone" required/><br><br>
          <h6 style='font-style:italic'>Data de Nascimento:</h6> <input type="text" maxlength="15" name="nascimento" required/><br><br>

          <input type="submit" name="cadastrar-paciente" value="Cadastrar" button type="button" class="btn btn-outline-dark"/>
        </form>
      </center>
    </div>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
  </body>
</html>
