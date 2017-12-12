<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="br.com.fatecpg.project.Database"%>
<%@page import="br.com.fatecpg.project.User"%>
<%@page import="br.com.fatecpg.project.Medico"%>
<!DOCTYPE html>
<% 
   if(session.getAttribute("me.login")==null){
       response.sendRedirect(request.getContextPath() + "/home.jsp"); 
   }

   String registerErrorMessage = null;
   String registerCompleteMessage = null;
   if (request.getParameter("cadastroMedico") != null) {
      SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
       
      String CRM = request.getParameter("crm");
      String UF = request.getParameter("uf");
      String registerCRM = CRM + "-" + UF;
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
      try {
         User adm = User.getUser(admLogin, admPass);
         Medico m = Medico.checkMedico(registerCRM);
         if (adm != null) {
            if(m == null){
                m.addMedico(registerCRM, registerNome, registerEmail,
                            registerEspec, registerDtNasc, registerTel,
                            registerEnd, registerCidade, registerEstado);
                registerCompleteMessage = "Cadastro realizado com sucesso";
             }else{
                registerErrorMessage = "Médico já existente";
             }
         } else {
             registerErrorMessage = "Login e/ou senha de administrador inválidos";
         }
      } catch (Exception ex) {
         registerErrorMessage = ex.getMessage();
      }
   }
   
    String estado[] = {"", "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
    "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RO", "RS",
    "RR", "SC", "SE", "SP", "TO"};
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthcare - Cadastrar médico</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        
        <h1>Cadastrar Médico</h1>
        
        <%if (registerErrorMessage != null) {%>
        <div style="color: red;"><%=registerErrorMessage%></div>
        <%}else if(registerCompleteMessage != null) {%>
        <div style="color: blue;"><%=registerCompleteMessage%></div>
        <%}%>
        
        <form method="post">
                CRM:<br/>
                <input required type="text" name="crm" maxlength="10">
                UF:
                <select name="uf" >
                    <%for (int c = 0; c <= 27; c++){%>
                       <option value="<%=estado[c]%>"><%=estado[c]%></option>
                    <%}%>
                </select><br/>
                Nome:<br/>
                <input required type="text" name="nomeMedico"/><br/>
                Email:<br/>
                <input required type="email" name="emailMedico"/><br/>
                Especialização:<br/>
                <input required type="text" name="especializacao"/><br/>
                Data de Nascimento:<br/>
                <input required type="text" pattern="^[0-3][0-9]\/[0-1][0-9]\/[0-2][0-9]{3}$" name="dataNascimento"/>
                <i>Utilize o formato dd/mm/aaaa</i><br/>
                Telefone:<br/>
                <input required type="text" pattern="^\([1-9]{2}\)[2-9][0-9]{3,4}\-[0-9]{4}$" name="telefoneMedico"/>
                <i>Utilize o formato (00)0000-0000</i><br/>
                Endereço:<br/>
                <input required type="text" name="enderecoMedico"/><br/>
                Cidade:<br/>
                <input required type="text" name="cidadeMedico"/>
                Estado:
                <select name="estadoMedico" >
                    <%for (int c = 0; c <= 27; c++){%>
                       <option value="<%=estado[c]%>"><%=estado[c]%></option>
                    <%}%>
                </select><br/><br/>
                    Login do Administrador:<br/>
                    <input type="text" name="adminLogin"><br/>
                    Senha do Administrador:<br/>
                    <input type="password" name="adminPass"><br/><br/>
                
            <input type="submit" name="cadastroMedico" value="Cadastrar"/>
        </form>
        <br/><br/>
        <b><a href="home.jsp" style='font-style: italic; color: #00BFFF'> <- Voltar</a></b> 
        
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
