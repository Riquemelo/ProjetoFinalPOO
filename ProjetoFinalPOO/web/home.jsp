<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String loginErrorMessage = null;
   if (request.getParameter("do-login") != null) {
      String login = request.getParameter("login");
      String pass = request.getParameter("pass");
      try {
         User u = User.getUser(login, pass);
         if (u == null) {
            loginErrorMessage = "Login e/ou senha não encontrados";
         } else {
            session.setAttribute("me.id", u.getId());
            session.setAttribute("me.nome", u.getNome());
            session.setAttribute("me.login", u.getLogin());
            session.setAttribute("me.passwordHash", u.getPasswordHash());
         }
      } catch (Exception ex) {
         loginErrorMessage = ex.getMessage();
      }
   }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Healthcare - Home</title>
  </head>
  <body>
    <%@include file="WEB-INF/jspf/header.jspf" %>
    <div class="container">
      <center>
        <%if (loginErrorMessage != null) {%>
        <div style="color: red;"><%=loginErrorMessage%></div>
        <%}%>
        <%if (session.getAttribute("me.login") != null) {%>
        <br><br>

        <div class="row">
          <div class="col-md-2 offset-md-1">
            <button button type="button" class="btn btn-outline-dark"><a href="cadastroMedico.jsp">Cadastrar Medico</a></button>
          </div>

          <div class="col-md-2">
            <button button type="button" class="btn btn-outline-dark"><a href="cadastroPaciente.jsp">Cadastrar Paciente</a></button>
          </div>

          <div class="col-md-2">
            <button button type="button" class="btn btn-outline-dark"><a href="listaMedico.jsp">Médicos Cadastrados</a></button>
          </div>

          <div class="col-md-2">
            <button button type="button" class="btn btn-outline-dark"><a href="listarPaciente.jsp">Pacientes Cadastrados</a></button>
          </div>

          <div class="col-md-2">
            <button button type="button" class="btn btn-outline-dark"><a href="listaConsulta.jsp">Consultas Cadastradas</a></button>
          </div>

        </div>
        <br/><br><br><br>
        <%} else {%>
        <form method="post">
          <h2 style='font-style:italic'>Login</h2> <br>
          <h6 style='font-style: italic'>Login:</h6>
          <input type="text" name="login"/><br/><br>
          <h6 style='font-style: italic'>Senha:</h6>
          <input type="password" name="pass"/><br/><br/><br>
          <input type="submit" name="do-login" value="Entrar" button type="button" class="btn btn-outline-dark"/> <br><br>
          <b> <a href="cadastroUser.jsp" style="font-style:italic; color: #00BFFF">Cadastre-se</a> </b>
        </form>
        <br/>

        <%}%>
      </center>
    </div>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
  </body>
</html>
