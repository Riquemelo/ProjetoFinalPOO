<%@page import="br.com.fatecpg.project.Medico"%>
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
    <title>Healthcare- Seleção de Médico</title>

    <link rel="stylesheet" type="text/css" href="css/custom.css">
  </head>
  <body>

    <%@include file="WEB-INF/jspf/header.jspf" %>

    <h1>Selecione um Médico</h1>

    <div class="container">
      <div class="row">
        <%try {%>
        <%for (Medico m : Medico.getMedicoList()) {%>

        <div class="col-md-3">
          <a href="#" class="medic">
            <div class="medico">
              <i class="fa fa-user-md"></i>
              <h1><%= m.getNome()%></h1>
              <h2><%= m.getEspec()%></h2>
            </div>
          </a>
        </div>

        <%}%>
        <%} catch (Exception e) {%>
        <div style="color: red;"><%=e.getMessage()%></div>
        <%}%>
      </div>
    </div>

    <%@include file="WEB-INF/jspf/footer.jspf" %>

  </body>
</html>
