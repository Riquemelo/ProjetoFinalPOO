<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.com.fatecpg.project.Consulta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String mensagemExcluir = null;
   String updateErrorMessage = null;
   if (session.getAttribute("me.login") == null) {
      response.sendRedirect(request.getContextPath() + "/home.jsp");
   }

   if (request.getParameter("deletar-consulta") != null) {
      String id = request.getParameter("id");
      Consulta.DeleteConsulta(id);
      mensagemExcluir = "Consulta excluida com sucesso";
   }
   if (request.getParameter("atualizar-consulta") != null) {

      SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

      String crm = request.getParameter("crm");
      String cpf = request.getParameter("cpf");
      String hora = request.getParameter("hora");

      SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
      Date data = new Date(formatter.parse(request.getParameter("data")).getTime());

      String motivo = request.getParameter("motivo");
      String valorS = request.getParameter("valor");

      double valor = Double.parseDouble(valorS);

      String id = request.getParameter("id");
      try {
         Consulta c = Consulta.getConsulta(cpf);
         c.updateConsulta(crm, cpf, hora, data, motivo, valor, id);
         response.sendRedirect(request.getContextPath() + "/listaConsulta.jsp");

      } catch (Exception ex) {
         updateErrorMessage = ex.getMessage();
      }
   }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Consultas Cadastradas</title>
    <link rel="stylesheet" type="text/css" href="css/custom.css">
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>

    <div class="container-fluid">
      <div align="left">
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
      </div>
      <center>
        <br><br><br>

        <%if (request.getParameter("alterar-consulta") != null) {
              String id = request.getParameter("id");
              Consulta cd = Consulta.getConsulta(id);

              if (updateErrorMessage != null) {%>
        <div style="color: red;"><%=updateErrorMessage%></div>
        <%}%>

        <h2 style='font-style:italic'>Editar Consulta</h2><br>

        <form method="post">
          <input type="hidden" name="alterar-medico" value="Alterar">
          <h6 style='font-style:italic'> CRM Médico: </h6>
          <input required type="text" name="crm" maxlength="13" value="<%=cd.getIdMedico()%>">
          <br><br>
          <h6 style='font-style:italic'> CPF Paciente: </h6>
          <input required type="text" class="cpf" name="cpf" value="<%=cd.getIdPaciente()%>"/><br/><br>
          <h6 style='font-style:italic'> Hora da Consulta:</h6>
          <input required type="text" class="hora" name="hora" value="<%=cd.getHora()%>"/><br/> <br>
          <h6 style='font-style:italic'> Data da Consulta:</h6>
          <input required type="text" class="data" pattern="^[0-3][0-9]\/[0-1][0-9]\/[0-2][0-9]{3}$" name="data" placeholder="dd/mm/aaaa" value="<%=cd.getData()%>"/><br><br>
          <h6 style='font-style:italic'> Motivo:</h6>
          <input required type="text" name="motivo" value="<%=cd.getMotivo()%>"/><br/><br>
          <h6 style='font-style:italic'>Valor:</h6>
          <input required class="numero" type="number" name="valor" value="<%=cd.getValor()%>"/><br><br>
          <input type="hidden" name="id" value="<%=id%>"/>

          <input type="submit" name="atualizar-consulta" value="Update" button type="button" class="btn btn-outline-dark"/>
          <br><br><br>

          <%}%>

          <h2 style='font-style:italic'>Consultas Cadastradas</h2><br><br>
          <%if (mensagemExcluir != null) {%>
          <div style="color: blue;"><%=mensagemExcluir%></div>
          <%}%>

          <table border="1" class="table table-hover">
            <tr>
              <th>ID</th>
              <th>CRM Médico</th>
              <th>CPF Paciente</th>
              <th>Hora da Consulta</th>
              <th>Data da Consulta</th>
              <th>Motivo</th>
              <th>Valor</th>
              <th>Alterar</th>
              <th>Excluir</th>
            </tr>
            <%try {%>
            <%for (Consulta c : Consulta.getConsultaList()) {%>
            <tr>
              <td><%= c.getId()%></td>
              <td><%= c.getIdMedico()%></td>
              <td><%= c.getIdPaciente()%></td>
              <td><%= c.getHora()%></td>
              <td><%= c.getData()%></td>
              <td><%= c.getMotivo()%></td>
              <td><%= c.getValor()%></td>
              <td>
                <form>
                  <input type="hidden" name="id"
                         value="<%=c.getId()%>"/>
                  <input type="submit" name="alterar-consulta"
                         value="Alterar"/>
                </form>
              </td>
              <td>
                <form>
                  <input type="hidden" name="id"
                         value="<%=c.getId()%>"/>
                  <input type="submit" name="deletar-consulta"
                         value="Excluir"/>
                </form>
              </td>
            </tr>

            <%}%>
            <%} catch (Exception e) {%>
            <div style="color: red;"><%=e.getMessage()%></div>
            <%}%>
          </table>
          <br/>
      </center>

    </div>

    <%@include file="WEB-INF/jspf/footer.jspf" %>

  </body>
</html>
