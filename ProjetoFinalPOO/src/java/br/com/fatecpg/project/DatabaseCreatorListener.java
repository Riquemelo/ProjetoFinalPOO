package br.com.fatecpg.project;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DatabaseCreatorListener implements ServletContextListener {
    private void createMedicoTable(Statement s){
        try{
            s.execute(  "CREATE TABLE medico(\n" +
                        "    cd_crm_medico INTEGER PRIMARY KEY\n" +
                        "    , nm_medico VARCHAR(50) NOT NULL\n" +
                        "    , nm_especializacao VARCHAR(50)  NOT NULL\n"+ 
                        "    , hr_atendimento_inicial TIME NOT NULL"+
                        "    , hr_atendimento_final TIME NOT NULL"+
                        "    , nm_login VARCHAR(50) NOT NULL"+
                        "    , cd_hashpass VARCHAR(200) NOT NULL" +
                        ")");
            System.out.println("Criada tabela medico.");
            s.execute( "INSERT INTO medico VALUES(\n" +
                        "    111111111 " +
                        "    , 'Jorge' " +
                        "    , 'Cirurgia'" +
                        "    , '09:30'" +
                        "    , '18:30'" +
                        "    , 'DrJorge'" +
                        "    , '123456'");
        }catch(Exception ex2){
            System.out.println("Erro ao criar a hour_price: "+ex2.getMessage());
        }
    }
    private void createPacienteTable(Statement s){
        try{
            s.execute(  "CREATE TABLE paciente(\n" +
                        "    cd_id_paciente INTEGER PRIMARY KEY\n" +
                        "    , nm_name VARCHAR(100) NOT NULL\n" +
                            "    , cd_registro_geral VARCHAR(13) NOT NULL\n" +
                        "    , cd_telefone VARCHAR(10) NOT NULL\n" +
                        ")");
            System.out.println("Criada tabela paciente.");
        }catch(Exception ex2){
            System.out.println("ErRo ao criar a paciente: "+ex2.getMessage());
        }
    }
    private void createConsultaTable(Statement s){
        try{
            s.execute(  "CREATE TABLE consulta(\n" +
                        "    cd_consulta INTEGER PRIMARY KEY"+
                        "    , cd_id_paciente INTEGER NOT NULL\n" +
                        "    , cd_crm_medico INTEGER NOT NULL\n" +
                        "    , hr_consulta TIME NOT NULL\n" +
                        "    , dt_consulta DATE NOT NULL\n" +
                        ")");
            System.out.println("Criada tabela consulta.");
        }catch(Exception ex2){
            System.out.println("Erro ao criar a consulta: "+ex2.getMessage());
        }
    }
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try{
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            String url = "jdbc:derby:c:/derby/ProjetoHealthcare;create=true";
            Connection c = DriverManager.getConnection(url);
            Statement s = c.createStatement();
            System.out.println("Iniciando a criação do BD.");
            createMedicoTable(s);
            createPacienteTable(s);
            createConsultaTable(s);
            s.close();
            c.close();
            DriverManager.getConnection
            ("jdbc:derby:c:/derby/ProjetoHealthcare;shutdown=true");
        }catch(Exception ex){
            System.out.println("Erro: "+ex.getMessage());
        }
    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
}