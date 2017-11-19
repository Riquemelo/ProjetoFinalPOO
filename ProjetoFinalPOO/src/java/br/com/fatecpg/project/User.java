package br.com.fatecpg.project;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

    public class User {
    private int id;
    private String name;
    private String hora_inicial;
    private String hora_final;
    private String login;
    private String passwordHash;
    
    
    public static User getUser(String login, String password) throws SQLException{
        Statement s = Database.getConnection().createStatement();
        ResultSet rs = s.executeQuery("SELECT * FROM medico "
                        + "WHERE nm_login='"+login+"' "
                        + "AND cd_hashpass='"+password.hashCode()+"'");
        User u = null;
        if(rs.next()){
            u = new User(rs.getInt("cd_crm_medico")
                    , rs.getString("nm_medico")
                    , rs.getString("hr_atendimento_inicial")
                    , rs.getString("hr_atendimento_final")
                    , rs.getString("nm_login")
                    , rs.getString("cd_hashpass"));
        }
        rs.close();
        s.close();
        return u;
    }

    public String getHora_inicial() {
        return hora_inicial;
    }

    public void setHora_inicial(String hora_inicial) {
        this.hora_inicial = hora_inicial;
    }

    public String getHora_final() {
        return hora_final;
    }

    public void setHora_final(String hora_final) {
        this.hora_final = hora_final;
    }

    public User(int id, String name, String login, String passwordHash, String hora_inicial, String hora_final) {
        this.id = id;
        this.name = name;
        this.hora_inicial = hora_inicial;
        this.hora_final = hora_final;
        this.login = login;
        this.passwordHash = passwordHash;
        
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
    
}