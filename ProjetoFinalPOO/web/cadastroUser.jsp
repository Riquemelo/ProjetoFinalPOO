<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="br.com.fatecpg.project.Database"%>
<%@page import="br.com.fatecpg.project.User"%>
<!DOCTYPE html>
<%
   String registerErrorMessage = null;
   String registerCompleteMessage = null;
   if (request.getParameter("cadastro") != null) {
      String registerUsername = request.getParameter("nomeUsuario");
      String registerLogin = request.getParameter("cadastroLogin");
      String registerPass = request.getParameter("cadastroSenha");
      String admLogin = request.getParameter("adminLogin");
      String admPass = request.getParameter("adminPass");
      try {
         User adm = User.getUser(admLogin, admPass);
         User r = User.getUser(registerLogin, registerPass);
         if (adm == null) {
            registerErrorMessage = "Login e/ou senha de administrador não encontrados";
         } else {
             if(r == null){
                r.addUser(registerUsername, registerLogin, registerPass);
                registerCompleteMessage = "Cadastro realizado com sucesso";
             }else{
                registerErrorMessage = "Login e/ou senha já existente";
             }
         }
      } catch (Exception ex) {
         registerErrorMessage = ex.getMessage();
      }
   }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Usuário</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h1>Cadastro de Usuário</h1>
        
        <%if (registerErrorMessage != null) {%>
        <div style="color: red;"><%=registerErrorMessage%></div>
        <%}else if(registerCompleteMessage != null) {%>
        <div style="color: blue;"><%=registerCompleteMessage%></div>
        <%}%>
        
        <form method="post">
                Nome do Usuário:<br/>
                <input type="text" name="nomeUsuario"><br/>
                Login:<br/>
                <input type="text" name="cadastroLogin"><br/>
                Senha:<br/>
                <input type="password" name="cadastroSenha"><br/><br/>
                
                Login do Administrador:<br/>
                <input type="text" name="adminLogin"><br/>
                Senha do Administrador:<br/>
                <input type="password" name="adminPass"><br/><br/> 
                
            <input type="submit" name="cadastro" value="Cadastrar">
        </form>
        <br/><br/>
        <a href="home.jsp"> <- Voltar</a>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
