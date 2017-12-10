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
            response.sendRedirect(request.getContextPath() + "/index.jsp");
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

    <h1>Login</h1>

    <%if (loginErrorMessage != null) {%>
    <div style="color: red;"><%=loginErrorMessage%></div>
    <%}%>

    <form method="post">
      Login:<br/>
      <input type="text" name="login"/><br/>
      Senha:<br/>
      <input type="password" name="pass"/><br/><br/>
      <input type="submit" name="do-login" value="Entrar"/>
    </form>
    <br/>
    <a href="cadastroUser.jsp">Cadastre-se</a>

    <%@include file="WEB-INF/jspf/footer.jspf" %>
  </body>
</html>
