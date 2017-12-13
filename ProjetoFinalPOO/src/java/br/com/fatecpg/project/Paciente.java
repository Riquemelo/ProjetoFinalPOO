package br.com.fatecpg.project;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Paciente {

   private int id;
   private String cpf;
   private String nome;
   private String rg;
   private String email;
   private String endereco;
   private String cidade;
   private String estado;
   private String sexo;
   private String telefone;
   private Date nascimento;
   
   public static Paciente getPacienteId(String idS) throws Exception {
      Paciente p = null;
      String SQL = "SELECT * FROM paciente WHERE cd_paciente=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idS);
      s.setInt(1, id);
      ResultSet rs = s.executeQuery();
      
      if (rs.next()) {
         p = new Paciente(rs.getInt("cd_paciente"),
                 rs.getString("cd_cpf"),
                 rs.getString("nm_name"),
                 rs.getString("cd_registro_geral"),
                 rs.getString("nm_email"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"),
                 rs.getString("ic_sexo"),
                 rs.getString("cd_telefone"),
                 rs.getDate("dt_nascimento"));

      }
      rs.close();
      s.close();
      return p;
   }
   
   public static Paciente getPaciente(String cpf) throws SQLException {
      String SQL = "SELECT * FROM paciente WHERE cd_cpf=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);

      s.setString(1, cpf);
      ResultSet rs = s.executeQuery();
      Paciente p = null;
      if (rs.next()) {
         p = new Paciente(rs.getInt("cd_paciente"),
                 rs.getString("cd_cpf"),
                 rs.getString("nm_name"),
                 rs.getString("cd_registro_geral"),
                 rs.getString("nm_email"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"),
                 rs.getString("ic_sexo"),
                 rs.getString("cd_telefone"),
                 rs.getDate("dt_nascimento"));

      }
      rs.close();
      s.close();
      return p;
   }
   
   public static void updatePaciente(String cpf, String nome, String rg, String email,
                                String endereco, String cidade, String estado,
                                String sexo, String telefone, Date nasc, String idS)throws Exception{
        String SQL = "UPDATE paciente"
                + " SET cd_cpf=?, nm_name=?, nm_registro_geral=?,"
                + " nm_email=?, nm_endereco=?, nm_cidade=?, nm_estado=?,"
                + " ic_sexo=?, cd_telefone=?"
                + " WHERE cd_paciente=?";
        
        PreparedStatement s = Database.getConnection().prepareStatement(SQL);
        int id = Integer.parseInt(idS);
        s.setString(1, cpf);
        s.setString(2, nome);
        s.setString(3, rg);
        s.setString(4, email);
        s.setString(5, endereco);
        s.setString(6, cidade);
        s.setString(7, estado);
        s.setString(8, sexo);
        s.setString(9, telefone);
        s.setDate(10, nasc);
        s.setInt(11, id);
        s.execute();
        s.close();
    }

   public static void addPaciente(String cpf, String nome, String rg, String email, String endereco, String cidade, String estado, String sexo, String telefone, Date nascimento) throws Exception {
      String SQL = "INSERT INTO paciente VALUES(" + "default,?,?,?,?,?,?,?,?,?,?)";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setString(1, cpf);
      s.setString(2, nome);
      s.setString(3, rg);
      s.setString(4, email);
      s.setString(5, endereco);
      s.setString(6, cidade);
      s.setString(7, estado);
      s.setString(8, sexo);
      s.setString(9, telefone);
      s.setDate(10, nascimento);
      s.execute();
      s.close();
   }

   public static ArrayList<Paciente> getPacienteList() throws Exception {
      ArrayList<Paciente> list = new ArrayList<>();
      Statement s = Database.getConnection().createStatement();
      ResultSet rs = s.executeQuery("SELECT * FROM paciente");
      while (rs.next()) {
         Paciente pl = new Paciente(
                 rs.getInt("cd_paciente"),
                 rs.getString("cd_cpf"),
                 rs.getString("nm_name"),
                 rs.getString("cd_registro_geral"),
                 rs.getString("nm_email"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"),
                 rs.getString("ic_sexo"),
                 rs.getString("cd_telefone"),
                 rs.getDate("dt_nascimento")
         );
         list.add(pl);
      }
      rs.close();
      s.close();
      return list;
   }
   public static void DeletePaciente(String idS) throws SQLException {
      String SQL = "DELETE FROM paciente WHERE cd_paciente=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idS);
      s.setInt(1, id);
      s.execute();
      s.close();
   }

   public Paciente(int id, String cpf, String nome, String rg, String email, String endereco, String cidade, String estado, String sexo, String telefone, Date nascimento) {
      this.id = id;
      this.cpf = cpf;
      this.nome = nome;
      this.rg = rg;
      this.email = email;
      this.endereco = endereco;
      this.cidade = cidade;
      this.estado = estado;
      this.sexo = sexo;
      this.telefone = telefone;
      this.nascimento = nascimento;
   }

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public String getCpf() {
      return cpf;
   }

   public void setCpf(String cpf) {
      this.cpf = cpf;
   }

   public String getNome() {
      return nome;
   }

   public void setNome(String nome) {
      this.nome = nome;
   }

   public String getRg() {
      return rg;
   }

   public void setRg(String rg) {
      this.rg = rg;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getEndereco() {
      return endereco;
   }

   public void setEndereco(String endereco) {
      this.endereco = endereco;
   }

   public String getCidade() {
      return cidade;
   }

   public void setCidade(String cidade) {
      this.cidade = cidade;
   }

   public String getEstado() {
      return estado;
   }

   public void setEstado(String estado) {
      this.estado = estado;
   }

   public String getSexo() {
      return sexo;
   }

   public void setSexo(String sexo) {
      this.sexo = sexo;
   }

   public String getTelefone() {
      return telefone;
   }

   public void setTelefone(String telefone) {
      this.telefone = telefone;
   }

   public Date getNascimento() {
      return nascimento;
   }

   public void setNascimento(Date nascimento) {
      this.nascimento = nascimento;
   }

}
