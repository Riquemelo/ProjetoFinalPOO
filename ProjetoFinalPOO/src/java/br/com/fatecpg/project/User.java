package br.com.fatecpg.project;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User {

   private int id;
   private String nome;
   private String login;
   private String passwordHash;

   public static User getUser(String login, String password) throws SQLException {
      String SQL = "SELECT * FROM usuario WHERE nm_login_usuario=? AND cd_hashpass=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setString(1, login);
      s.setString(2, password.hashCode() + "");
      ResultSet rs = s.executeQuery();
      User u = null;
      if (rs.next()) {
         u = new User(rs.getInt("cd_usuario"),
                 rs.getString("nm_usuario"),
                 rs.getString("nm_login_usuario"),
                 rs.getString("cd_hashpass"));
      }
      rs.close();
      s.close();
      return u;
   }
   public static User getAdminUser(String login, String password) throws SQLException {
      String SQL = "SELECT * FROM usuario WHERE nm_login_usuario=? AND cd_hashpass=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setString(1, login);
      s.setString(2, password.hashCode() + "");
      ResultSet rs = s.executeQuery();
      User u = null;
      if (rs.next()) {
         u = new User(rs.getInt("cd_usuario"),
                 rs.getString("nm_usuario"),
                 rs.getString("nm_login_usuario"),
                 rs.getString("cd_hashpass"));
      }
      rs.close();
      s.close();
      return u;
   }
   public static void addUser(String username, String login, String password)throws Exception{
        String SQL = "INSERT INTO usuario VALUES("
                + "default,?,?,?)";
        PreparedStatement s = Database.getConnection().prepareStatement(SQL);
        s.setString(1, username);
        s.setString(2, login);
        s.setString(3, password.hashCode() + "");
        s.execute();
        s.close();
    }

   public User(int id, String nome, String login, String passwordHash) {
      this.id = id;
      this.nome = nome;
      this.login = login;
      this.passwordHash = passwordHash;
   }

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public String getNome() {
      return nome;
   }

   public void setNome(String nome) {
      this.nome = nome;
   }

   public String getLogin() {
      return login;
   }

   public void setLogin(String login) {
      this.login = login;
   }

   public String getPasswordHash() {
      return passwordHash;
   }

   public void setPasswordHash(String passwordHash) {
      this.passwordHash = passwordHash;
   }

}
