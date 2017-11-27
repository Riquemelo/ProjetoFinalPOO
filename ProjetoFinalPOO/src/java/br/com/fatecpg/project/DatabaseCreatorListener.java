package br.com.fatecpg.project;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DatabaseCreatorListener implements ServletContextListener {

   private void createMedicoTable(Statement s) {
      try {
         s.execute("CREATE TABLE medico(\n"
                 + "    cd_medico INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)\n"
                 + "    , cd_crm_medico INTEGER\n"
                 + "    , nm_medico VARCHAR(50) NOT NULL\n"
                 + "    , nm_email VARCHAR(50) NOT NULL\n"
                 + "    , nm_especializacao VARCHAR(50)  NOT NULL\n"
                 + "    , dt_nascimento DATE NOT NULL\n"
                 + "    , cd_telefone VARCHAR(10) NOT NULL\n"
                 + "    , nm_endereco VARCHAR(100) NOT NULL\n"
                 + "    , nm_cidade VARCHAR(100) NOT NULL\n"
                 + "    , nm_estado VARCHAR(50) NOT NULL"
                 + ")");
         System.out.println("Criada tabela medico.");
      } catch (Exception ex2) {
         System.out.println("Erro ao criar a hour_price: " + ex2.getMessage());
      }
   }

   private void createPacienteTable(Statement s) {
      try {
         s.execute("CREATE TABLE paciente(\n"
                 + "    cd_paciente INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)\n"
                 + "    , nm_name VARCHAR(100) NOT NULL\n"
                 + "    , nm_email VARCHAR(100) NOT NULL\n"
                 + "    , nm_endereco VARCHAR(100) NOT NULL\n"
                 + "    , nm_cidade VARCHAR(100) NOT NULL\n"
                 + "    , nm_estado VARCHAR(50) NOT NULL\n"
                 + "    , cd_registro_geral VARCHAR(13) NOT NULL\n"
                 + "    , cd_cpf VARCHAR(11) NOT NULL\n"
                 + "    , cd_telefone VARCHAR(10) NOT NULL\n"
                 + "    , dt_nascimento DATE NOT NULL"
                 + ")");
         System.out.println("Criada tabela paciente.");
      } catch (Exception ex2) {
         System.out.println("Erro ao criar a paciente: " + ex2.getMessage());
      }
   }

   private void createConsultaTable(Statement s) {
      try {
         s.execute("CREATE TABLE consulta(\n"
                 + "    cd_consulta INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)\n"
                 + "    , cd_paciente INTEGER NOT NULL\n"
                 + "    , cd_medico INTEGER NOT NULL\n"
                 + "    , hr_consulta TIMESTAMP NOT NULL\n"
                 + "    , dt_consulta TIMESTAMP NOT NULL\n"
                 + "    , vl_consulta NUMERIC(10,2) NOT NULL"
                 + ")");
         System.out.println("Criada tabela consulta.");
      } catch (Exception ex2) {
         System.out.println("Erro ao criar a consulta: " + ex2.getMessage());
      }
   }

   private void createUsuarioTable(Statement s) {
      try {
         s.execute("CREATE TABLE usario(\n"
                 + "    cd_usuario INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1)\n"
                 + "    , nm_usuario VARCHAR(50)\n"
                 + "    , nm_login_usuario VARCHAR(50) NOT NULL\n"
                 + "    , cd_hashpass VARCHAR(200) NOT NULL"
                 + ")");
         System.out.println("Criada tabela usuario.");
         s.execute("INSERT INTO usuario VALUES(\n"
                 + "    1 "
                 + "    , 'admin'"
                 + "    , 'admin'"
                 + "    , '123456'");
      } catch (Exception ex2) {
         System.out.println("Erro ao criar o usuario: " + ex2.getMessage());
      }
   }

   @Override
   public void contextInitialized(ServletContextEvent sce) {
      try {
         Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
         String url = "jdbc:derby:c:/derby/ProjetoHealthcare;create=true";
         Connection c = DriverManager.getConnection(url);
         Statement s = c.createStatement();
         System.out.println("Iniciando a criação do BD.");
         createMedicoTable(s);
         createPacienteTable(s);
         createConsultaTable(s);
         createUsuarioTable(s);
         s.close();
         c.close();
         DriverManager.getConnection("jdbc:derby:c:/derby/ProjetoHealthcare;shutdown=true");
      } catch (Exception ex) {
         System.out.println("Erro: " + ex.getMessage());
      }
   }

   @Override
   public void contextDestroyed(ServletContextEvent sce) {

   }
}
