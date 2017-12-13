<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.com.fatecpg.project.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String mensagemExcluir = null;
   String updateErrorMessage = null;
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }

   if (request.getParameter("deletar-paciente") != null) {
      String id = request.getParameter("id");
      Paciente.DeletePaciente(id);
      mensagemExcluir = "Registro excluido com sucesso";
   }
   if (request.getParameter("alterar-paciente") != null) {

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

      String idS = request.getParameter("id");
      try {

         Paciente p = Paciente.getPaciente(cpf);
         p.updatePaciente(cpf, nome, rg,
                 email, endereco, cidade,
                 estado, sexo, telefone, nascimento, idS);
         response.sendRedirect(request.getContextPath() + "/listarPaciente.jsp");

      } catch (Exception ex) {
         updateErrorMessage = ex.getMessage();
      }
   }

   String estado[] = {"", "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
      "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RO", "RS",
      "RR", "SC", "SE", "SP", "TO"};
   String sexo[] = {"", "Masculino", "Feminino"};
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Pacientes Cadastrados</title>
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>

    <div class="container-fluid">
      <div align="left">
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
      </div>

      <%if (request.getParameter("alterar-paciente") != null) {
            String id = request.getParameter("id");
            Paciente pt = Paciente.getPacienteId(id);%>

      <%if (updateErrorMessage != null) {%>
      <div style="color: red;"><%=updateErrorMessage%></div>
      <%}%>

      <h2 style='font-style:italic'>Editar Paciente</h2><br>

      <h6 style='font-style:italic'>Nome:</h6> <input  type="text" value="<%=pt.getNome()%>" maxlength="100" name="nome" required/><br><br>
      <h6 style='font-style:italic'> Rg: </h6><input value="<%=pt.getRg()%>" type="text" maxlength="9" name="rg" required/><br><br>
      <h6 style='font-style:italic'>Email:</h6> <input value="<%=pt.getEmail()%>" type="email" maxlength="100" name="email" required/><br><br>
      <h6 style='font-style:italic'>Endereco:</h6> <input value="<%=pt.getEndereco()%>" type="text" maxlength="100" name="endereco" required/><br><br>
      <h6 style='font-style:italic'> Cidade:</h6> <input value="<%=pt.getCidade()%>" type="text" maxlength="100" name="cidade" required/><br><br>
      <h6 style='font-style:italic'>Estado:</h6> <select name="estado" >
        <%for (int c = 0; c <= 27; c++) {%>
        <option value="<%=estado[c]%>" <%if (pt.getEstado().equals(estado[c]))%> selected <%;%>><%=estado[c]%></option>
        <%}%>
      </select><br/><br/>
      <h6 style='font-style:italic'>Sexo: </h6> <select name="sexo">
        <%for (int c = 0; c < 3; c++) {%>
        <option value="<%=sexo[c]%>" <%if (pt.getSexo().equals(sexo[c]))%> selected <%;%>><%=sexo[c]%></option>
        <%}%>
      </select><br><br>
      <h6 style='font-style:italic'>Telefone: </h6><input value="<%=pt.getTelefone()%>" type="text" maxlength="15" name="telefone" placeholder="(00)0000-0000" pattern="^\([1-9]{2}\)[2-9][0-9]{3,4}\-[0-9]{4}$" required/><br><br>
      <h6 style='font-style:italic'>Data de Nascimento:</h6> <input value="<%=pt.getNascimento()%>" type="text" maxlength="15" placeholder="dd/mm/aaaa" name="nascimento" required/><br><br>

      <input type="submit" name="alterar-paciente" value="Update" button type="button" class="btn btn-outline-dark"/>
      <br><br><br>

      <%}%>
      <center>
        <h2 style='font-style:italic'>Pacientes Cadastradas</h2><br><br>
        <%if (mensagemExcluir != null) {%>
        <div style="color: blue;"><%=mensagemExcluir%></div>
        <%}%>

        <table border="1" class="table table-hover">
          <tr>
            <th>CPF</th>
            <th>Nome</th>
            <th>RG</th>
            <th>Sexo</th>
            <th>Data de Nascimento</th>
            <th>Alterar</th>
            <th>Excluir</th>
            <th>Agendar</th>
          </tr>
          <%try {%>
          <%for (Paciente pl : Paciente.getPacienteList()) {%>
          <tr data-toggle="collapse" data-target="#accordion<%=pl.getId()%>" class="clickable">
            <td><%= pl.getCpf()%></td>
            <td><%= pl.getNome()%></td>
            <td><%= pl.getRg()%></td>
            <td><%= pl.getSexo()%></td>
            <td><%= pl.getNascimento()%></td>

            <td>
              <form>
                <input type="hidden" name="id"
                       value="<%=pl.getId()%>"/>
                <input type="submit" name="alterar-paciente"
                       value="Alterar"/>
              </form>
            </td>
            <td>
              <form>
                <input type="hidden" name="id"
                       value="<%=pl.getId()%>"/>
                <input type="submit" name="deletar-paciente"
                       value="Excluir"/>
              </form>
            </td>
            <td>
              <button><a class="no-effect" href="selecaoMedico.jsp?idPaciente=<%=pl.getCpf()%>">Agendar</a></button>
            </td>
          </tr>

          <tr>
            <td style="padding-top: 0px; padding-bottom: 0px;" colspan="6">
              <div style="padding-top: 5px; padding-bottom: 5px;"
                   id="accordion<%=pl.getId()%>" class="collapse">

                <b>Contato:</b> <%= pl.getTelefone()%> <b>Email:</b> <%= pl.getEmail()%> <br/>
                <b>Endereço:</b> <%= pl.getEndereco()%> - <%= pl.getCidade()%> , <%=pl.getEstado()%>

              </div>
            </td>
          </tr>
          <%}%>
          <%} catch (Exception e) {%>
          <div style="color: red;"><%=e.getMessage()%></div>
          <%}%>
        </table>

      </center>


    </div>
  </body>
</html>
