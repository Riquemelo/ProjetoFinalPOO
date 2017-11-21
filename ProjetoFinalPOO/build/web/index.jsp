<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.com.fatecpg.project.Database"%>
<%@page import="br.com.fatecpg.project.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthcare</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        
        <form method="post"> 
            Login: 
            <input type="text" name="login"/><br/><br/>
            Senha:
            <input type="password" name="pass"/><br/><br/>
            <input type="submit" name="Entrar" value="Entrar"/>
        </form>
        
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
