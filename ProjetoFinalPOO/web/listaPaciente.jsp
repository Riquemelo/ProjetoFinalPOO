<%@page import="br.com.fatecpg.project.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String mensagemExcluir = null;
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }
   if (request.getParameter("alterar-paciente") != null){
       
   }else if(request.getParameter("deletar-paciente") != null){
       String id = request.getParameter("id");
       Paciente.DeletePaciente(id);
       mensagemExcluir = "Registro excluido com sucesso";
   }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Pacientes Cadastrados</title>
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>
    <div align="left">
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
    </div>
    <div class="container-fluid">
    <center>
    <br><br><br>

    <h2 style='font-style:italic'>Pacientes Cadastrados</h2><br><br>
    
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
        <th>Alterar / Excluir</th>
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
                   value="<%= pl.getId()%>"/>
            <input type="submit" name="alterar-paciente"
                   value="Alterar"/>
            <input type="submit" name="deletar-paciente"
                   value="Excluir"/>
          </form>
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
    </table><br>
    
             </center>
    </div><br>
    <%@include file="WEB-INF/jspf/footer.jspf" %>

  </body>
</html>
