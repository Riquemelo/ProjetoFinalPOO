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

      String cpfS = request.getParameter("cpf");
      String nome = request.getParameter("nome");
      String rgS = request.getParameter("rg");
      String email = request.getParameter("email");
      String endereco = request.getParameter("endereco");
      String cidade = request.getParameter("cidade");
      String estado = request.getParameter("estado");
      String sexo = request.getParameter("sexo");
      String telefoneS = request.getParameter("telefone");
      String nascimentoS = request.getParameter("nascimento");

      SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
      Date nascimento = new Date(formatter.parse(request.getParameter("nascimentoS")).getTime());

      int cpf = Integer.parseInt(cpfS);
      int rg = Integer.parseInt(rgS);
      int telefone = Integer.parseInt(telefoneS);

      try {
         Paciente.addPaciente(cpf, nome, rg, email, endereco, cidade, estado, sexo, telefone, nascimento);
         response.sendRedirect(request.getRequestURI());
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
  <center>
    <h1>Cadastrar de Paciente</h1>
  </center>

  <%if (cadastroErrorMessage != null) {%>
  <div style="color: red;"><%=cadastroErrorMessage%></div>
  <%}%>
  <form action="listaPaciente.jsp">
    CPF: <input type="text" maxlength="11" pattern="[0-9]+$" name="cpf" max required/>
    Nome: <input type="text" maxlength="100" name="nome" required/>
    Rg: <input type="text" maxlength="9" pattern="[0-9]+$" name="rg" required/>
    Email: <input type="email" maxlength="100" name="email" required/>
    Endereco: <input type="text" maxlength="100" name="endereco" required/>
    Cidade: <input type="text" maxlength="100" name="cidade" required/>
    Estado: <input type="text" maxlength="100" name="estado" required/>
    Sexo: <input type="text" maxlength="30" name="sexo" required/>
    Telefone: <input type="text" maxlength="15" name="telefone" required/>
    Data de Nascimento: <input type="text" maxlength="15" name="nascimento" required/>

    <input type="submit" name="cadastrar-paciente" value="Cadastrar"/>
  </form>

</body>
</html>
