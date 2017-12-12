package br.com.fatecpg.project;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Paciente {

   private int id;
   private int cpf;
   private String nome;
   private int rg;
   private String email;
   private String endereco;
   private String cidade;
   private String estado;
   private String sexo;
   private int telefone;
   private Date nascimento;

   public static Paciente getPaciente(String cpfA) throws SQLException {
      String SQL = "SELECT * FROM paciente WHERE cd_cpf=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int cpf = Integer.parseInt(cpfA);
      s.setInt(1, cpf);
      ResultSet rs = s.executeQuery();
      Paciente p = null;
      if (rs.next()) {
         p = new Paciente(rs.getInt("cd_paciente"),
                 rs.getInt("cd_cpf"),
                 rs.getString("nm_name"),
                 rs.getInt("cd_registro_geral"),
                 rs.getString("nm_email"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"),
                 rs.getString("ic_sexo"),
                 rs.getInt("cd_telefone"),
                 rs.getDate("dt_nascimento"));

      }
      rs.close();
      s.close();
      return p;
   }

   public static void addPaciente(int cpf, String nome, int rg, String email, String endereco, String cidade, String estado, String sexo, int telefone, Date nascimento) throws Exception {
      String SQL = "INSERT INTO paciente VALUES(" + "default,?,?,?,?,?,?,?,?,?,?)";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setInt(1, cpf);
      s.setString(2, nome);
      s.setInt(3, rg);
      s.setString(4, email);
      s.setString(5, endereco);
      s.setString(6, cidade);
      s.setString(7, estado);
      s.setString(8, sexo);
      s.setInt(9, telefone);
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
                 rs.getInt("cd_cpf"),
                 rs.getString("nm_name"),
                 rs.getInt("cd_registro_geral"),
                 rs.getString("nm_email"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"),
                 rs.getString("ic_sexo"),
                 rs.getInt("cd_telefone"),
                 rs.getDate("dt_nascimento")
         );
         list.add(pl);
      }
      rs.close();
      s.close();
      return list;
   }

   public Paciente(int id, int cpf, String nome, int rg, String email, String endereco, String cidade, String estado, String sexo, int telefone, Date nascimento) {
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

   public String getNome() {
      return nome;
   }

   public void setNome(String nome) {
      this.nome = nome;
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

   public int getRg() {
      return rg;
   }

   public void setRg(int rg) {
      this.rg = rg;
   }

   public int getCpf() {
      return cpf;
   }

   public void setCpf(int cpf) {
      this.cpf = cpf;
   }

   public int getTelefone() {
      return telefone;
   }

   public void setTelefone(int telefone) {
      this.telefone = telefone;
   }

   public Date getNascimento() {
      return nascimento;
   }

   public void setNascimento(Date nascimento) {
      this.nascimento = nascimento;
   }

}
