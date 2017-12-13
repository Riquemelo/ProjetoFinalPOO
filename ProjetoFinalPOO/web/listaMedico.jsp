<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <% 
  String mensagemExcluir = null;
  if(session.getAttribute("me.login")==null){
       response.sendRedirect(request.getContextPath() + "/home.jsp"); 
  }
  if (request.getParameter("alterar-medico") != null){
       
  }else if(request.getParameter("deletar-medico") != null){
       String id = request.getParameter("id");
       Medico.DeleteMedico(id);
       mensagemExcluir = "Registro excluido com sucesso";
  }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthcare - Médicos</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <div class="container-fluid">
        <div align="left">
            <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
        </div>
             <center>
                 <br><br><br>
                 <h2 style='font-style:italic'>Médicos</h2><br><br>
        <%if (mensagemExcluir != null) {%>
            <div style="color: blue;"><%=mensagemExcluir%></div>
        <%}%>
        <table border="1" class="table table-hover">
            <tr>
                <th>CRM</th>
                <th>Nome</th>
                <th>Especialização</th>
                <th>Data de Nascimento</th>
                <th>Alterar / Excluir</th>
            </tr>
            <%try{%>
                <%for(Medico m: Medico.getMedicoList()){%>
                <tr data-toggle="collapse" data-target="#accordion<%=m.getId()%>" class="clickable">
                    <td><%= m.getCrm() %></td>
                    <td><%= m.getNome()%></td>
                    <td><%= m.getEspec()%></td>
                    <td><%= m.getNasc() %></td>
                    <td>
                        <form>
                          <input type="hidden" name="id"
                                 value="<%= m.getId()%>"/>
                          <input type="submit" name="alterar-medico"
                                 value="Alterar"/>
                          <input type="submit" name="deletar-medico"
                                 value="Excluir"/>
                        </form>
                    </td>
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
             </center>
        </div><br>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
