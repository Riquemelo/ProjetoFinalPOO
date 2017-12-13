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
         Paciente p = Paciente.checkPaciente(cpf);
         if (p == null) {
            Paciente.addPaciente(cpf, nome, rg, email, endereco, cidade, estado, sexo, telefone, nascimento);

            cadastroComplete = "Paciente cadastrado com sucesso!";
         } else {
            cadastroErrorMessage = "Paciente já cadastrado";
         }
      } catch (Exception e) {
         cadastroErrorMessage = e.getMessage();
      }
   }
   String estado[] = {"", "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
      "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RO", "RS",
      "RR", "SC", "SE", "SP", "TO"};
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Cadastro de Pacientes</title>

  </head>
  <body>
    <%@include file="WEB-INF/jspf/header.jspf" %>
    <div class="container-fluid">
      <div align="left">
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
      </div>
      <center>
        <br><br>
        <h2 style='font-style:italic'>Cadastrar de Paciente</h2><br>
      </center>

      <center>

        <%if (cadastroErrorMessage != null) {%>
        <div style="color: red;"><%=cadastroErrorMessage%></div>
        <%} else if (cadastroComplete != null) {%>
        <div style="color: blue;"><%=cadastroComplete%></div>
        <%}%>

        <form method="post">
          <h6 style='font-style:italic'>CPF: </h6> <input type="text" class="cpf" maxlength="11" name="cpf" max required/><br><br>
          <h6 style='font-style:italic'>Nome:</h6> <input type="text" maxlength="100" name="nome" required/><br><br>
          <h6 style='font-style:italic'> Rg: </h6><input class="rg" type="text" maxlength="9" name="rg" required/><br><br>
          <h6 style='font-style:italic'>Email:</h6> <input type="email" maxlength="100" name="email" required/><br><br>
          <h6 style='font-style:italic'>Endereco:</h6> <input type="text" maxlength="100" name="endereco" required/><br><br>
          <h6 style='font-style:italic'> Cidade:</h6> <input type="text" maxlength="100" name="cidade" required/><br><br>
          <h6 style='font-style:italic'>Estado:</h6> <select name="estado" >
            <%for (int c = 0; c <= 27; c++) {%>
            <option value="<%=estado[c]%>"><%=estado[c]%></option>
            <%}%>
          </select><br/><br/>
          <h6 style='font-style:italic'>Sexo: </h6> <select name="sexo">
            <option value=" "></option>
            <option value="Masculino">Masculino</option>
            <option value="Feminino">Feminino</option>
          </select><br><br>
          <h6 style='font-style:italic'>Telefone: </h6><input type="text" maxlength="15" name="telefone" placeholder="(00)0000-0000" class="telefone" required/><br><br>
          <h6 style='font-style:italic'>Data de Nascimento:</h6> <input class="data" pattern="^[0-3][0-9]\/[0-1][0-9]\/[0-2][0-9]{3}$" type="text" maxlength="15" placeholder="dd/mm/aaaa" name="nascimento" class="data" required/><br><br>

          <input type="submit" name="cadastrar-paciente" value="Cadastrar" button type="button" class="btn btn-outline-dark"/>
        </form>
        <br>
      </center>
    </div>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
  </body>
</html>
