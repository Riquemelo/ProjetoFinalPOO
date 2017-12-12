<%@page import="br.com.fatecpg.project.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Pacientes Cadastrados</title>
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>

    <h1>Pacientes Cadastrados</h1>

    <table border="1">
      <tr>
        <th>ID</th>
        <th>CPF</th>
        <th>Nome</th>
        <th>RG</th>
        <th>Email</th>
        <th>Endereco</th>
        <th>Cidade</th>
        <th>Estado</th>
        <th>Sexo</th>
        <th>Telefone</th>
        <th>Data de Nascimento</th>
      </tr>
      <%try {%>
      <%for (Paciente pl : Paciente.getPacienteList()) {%>
      <tr>
        <td><%= pl.getId()%></td>
        <td><%= pl.getCpf()%></td>
        <td><%= pl.getNome()%></td>
        <td><%= pl.getRg()%></td>
        <td><%= pl.getEmail()%></td>
        <td><%= pl.getEndereco()%></td>
        <td><%= pl.getCidade()%></td>
        <td><%= pl.getEstado()%></td>
        <td><%= pl.getSexo()%></td>
        <td><%= pl.getTelefone()%></td>
        <td><%= pl.getNascimento()%></td>
        <td>
          <form action="listaPaciente.jsp">
            <input type="hidden" name="id"
                   value="<%= pl.getId()%>"/>
            <input type="submit" name="alterar-paciente"
                   value="Alterar"/>
            <input type="submit" name="deletar-paciente"
                   value="Excluir"/>
          </form>
        </td>
      </tr>
      <%}%>
      <%} catch (Exception e) {%>
      <div style="color: red;"><%=e.getMessage()%></div>
      <%}%>
    </table>

    <%@include file="WEB-INF/jspf/footer.jspf" %>

  </body>
</html>
