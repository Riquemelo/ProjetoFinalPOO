<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <% 
  String mensagemExcluir = null;
  String updateErrorMessage = null;

  if(session.getAttribute("me.login")==null){
       response.sendRedirect(request.getContextPath() + "/home.jsp"); 
  }
  if(request.getParameter("deletar-medico") != null){
       String id = request.getParameter("id");
       Medico.DeleteMedico(id);
       mensagemExcluir = "Registro excluido com sucesso";
  }
  if(request.getParameter("atualizarMedico") != null){
      SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
       
      String registerCRM = request.getParameter("crm");
      String registerNome = request.getParameter("nomeMedico");
      String registerEmail = request.getParameter("emailMedico");
      String registerEspec = request.getParameter("especializacao");
      Date registerDtNasc = new Date(format.parse
                            (request.getParameter("dataNascimento")).getTime());
      String registerTel = request.getParameter("telefoneMedico");
      String registerEnd = request.getParameter("enderecoMedico");
      String registerCidade = request.getParameter("cidadeMedico");
      String registerEstado = request.getParameter("estadoMedico");
      String admLogin = request.getParameter("adminLogin");
      String admPass = request.getParameter("adminPass");
      String id = request.getParameter("id");
      try {
         User adm = User.getUser(admLogin, admPass);
         Medico m = Medico.checkMedico(registerCRM);
         if (adm != null) {
            m.updateMedico(registerCRM, registerNome, registerEmail,
                            registerEspec, registerDtNasc, registerTel,
                            registerEnd, registerCidade, registerEstado, id);
            response.sendRedirect(request.getContextPath() + "/listaMedico.jsp");
         } else {
             updateErrorMessage = "Login e/ou senha de administrador inválidos";
         }
      } catch (Exception ex) {
         updateErrorMessage = ex.getMessage();
      }
  }
  String estado[] = {"", "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
    "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RO", "RS",
    "RR", "SC", "SE", "SP", "TO"};
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthcare - Médicos Cadastrados</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <div class="container-fluid">
        <div align="left">
            <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b>
        </div>
             <center>
                 <br><br><br>
        <%if (request.getParameter("alterar-medico") != null){
            String id = request.getParameter("id");
            Medico md = Medico.getMedico(id);
            
        if (updateErrorMessage != null) {%>
        <div style="color: red;"><%=updateErrorMessage%></div>
        <%}%>
            
            <h2 style='font-style:italic'>Editar Médico</h2><br>
            
            <form method="post">
                <input type="hidden" name="alterar-medico" value="Alterar">
            <h6 style='font-style:italic'> CRM: </h6>
            <input required type="text" name="crm" maxlength="13" value="<%=md.getCrm()%>">
            <br><br>
                <h6 style='font-style:italic'> Nome: </h6>
                <input required type="text" name="nomeMedico" value="<%=md.getNome()%>"/><br/><br>
                <h6 style='font-style:italic'> Email:</h6>
                <input required type="email" name="emailMedico" value="<%=md.getEmail()%>"/><br/> <br>
                <h6 style='font-style:italic'>Especialização:</h6>
                <input required type="text" name="especializacao" value="<%=md.getEspec()%>"/><br/><br>
                <h6 style='font-style:italic'> Data de Nascimento:</h6>
                <input required type="text" pattern="^[0-3][0-9]\/[0-1][0-9]\/[0-2][0-9]{3}$" name="dataNascimento" placeholder="dd/mm/aaaa" value="<%=md.getNasc()%>"/><br><br>
                <h6 style='font-style:italic'>Telefone: </h6>
                <input required type="text" pattern="^\([1-9]{2}\)[2-9][0-9]{3,4}\-[0-9]{4}$" name="telefoneMedico" placeholder="(00)0000-0000" value="<%=md.getTelefone()%>"/> <br><br>
                <h6 style='font-style:italic'> Endereço:</h6>
                <input required type="text" name="enderecoMedico" value="<%=md.getEndereco()%>"/><br/><br>
                <h6 style='font-style:italic'>Cidade:</h6>
                <input required type="text" name="cidadeMedico" value="<%=md.getCidade()%>"/><br><br>
                <h6 style='font-style:italic'> Estado:</h6>
                <select name="estadoMedico">
                    <%for (int c = 0; c <= 27; c++){%>
                    <option value="<%=estado[c]%>" <%if(md.getEstado().equals(estado[c]))%> selected <%;%> ><%=estado[c]%></option>
                    <%}%>
                </select><br/><br/>
                <h6 style='font-style:italic'>Login do Administrador:</h6>
                <input type="text" name="adminLogin"><br/><br>
                <h6 style='font-style:italic'>Senha do Administrador:</h6>
                    <input type="password" name="adminPass"><br/><br/>
                
            <input type="submit" name="atualizarMedico" value="Atualizar" button type="button" class="btn btn-outline-dark"/>
            <br><br><br>
            
        <%}%>
                 
                 <h2 style='font-style:italic'>Médicos Cadastrados</h2><br><br>
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
                                 value="<%=m.getId()%>"/>
                          <input type="submit" name="alterar-medico"
                                 value="Alterar"/>
                          <input type="submit" name="deletar-medico"
                                 value="Excluir"/>
                        </form>
                    </td>
                </tr>
                
                <tr>
                    <td style="padding-top: 0px; padding-bottom: 0px;" colspan="5">
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
