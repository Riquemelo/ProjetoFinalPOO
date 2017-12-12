<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <% 
  if(session.getAttribute("me.login")==null){
       response.sendRedirect(request.getContextPath() + "/home.jsp"); 
  }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthcare - Médicos</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h1>Médicos</h1>
        <table border="1" class="table table-hover">
            <tr>
                <th>CRM</th>
                <th>Nome</th>
                <th>Especialização</th>
                <th>Data de Nascimento</th>
            </tr>
            <%try{%>
                <%for(Medico m: Medico.getMedicoList()){%>
                <tr data-toggle="collapse" data-target="#accordion<%=m.getId()%>" class="clickable">
                    <td><%= m.getCrm() %></td>
                    <td><%= m.getNome()%></td>
                    <td><%= m.getEspec()%></td>
                    <td><%= m.getNasc() %></td>
                </tr>
                
                <tr>
                    <td style="padding-top: 0px; padding-bottom: 0px;" colspan="4">
                        <div style="padding-top: 5px; padding-bottom: 5px;" 
                             id="accordion<%=m.getId()%>" class="collapse">
                        
                        <b>Contato:</b> <%= m.getTelefone()%> <b>Email:</b> <%= m.getEmail()%> <br/>
                        <b>Endereço:</b> <%= m.getEndereco()%> - <%= m.getCidade()%> , <%=m.getEstado()%>
                        
                        </div>
                    </td>
                </tr>
                
                <%}%>
            <%}catch(Exception e){%>
                <div style="color: red;"><%=e.getMessage()%></div>
            <%}%>
        </table>
        <br/>
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
