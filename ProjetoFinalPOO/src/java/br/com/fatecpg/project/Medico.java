package br.com.fatecpg.project;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;


public class Medico {
   private int id;
   private int crm;
   private String nome;
   private String email;
   private String espec;
   private Date nasc;
   private String telefone;
   private String endereco;
   private String cidade;
   private String estado;
   
   public static Medico getMedico(String Scrm, String nome) throws SQLException {
      String SQL = "SELECT * FROM medico WHERE cd_crm_medico=? AND nm_medico=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int crm = Integer.parseInt(Scrm);
      s.setInt(1, crm);
      s.setString(2, nome);
      ResultSet rs = s.executeQuery();
      Medico m = null;
      if (rs.next()) {
         m = new Medico(rs.getInt("cd_medico"),
                 rs.getInt("cd_crm_medico"),
                 rs.getString("nm_medico"),
                 rs.getString("nm_email"),
                 rs.getString("nm_especializacao"),
                 rs.getDate("dt_nascimento"),
                 rs.getString("cd_telefone"),
                 rs.getString("nm_endereco"),
                 rs.getString("nm_cidade"),
                 rs.getString("nm_estado"));
      }
      rs.close();
      s.close();
      return m;
   }
   
   public static void addMedico(String Scrm, String nome, String email, String espec,
                                Date nasc, String tel, String endereco,
                                String cidade, String estado)throws Exception{
        String SQL = "INSERT INTO medico VALUES("
                + "default,?,?,?,?,?,?,?,?,?)";
        PreparedStatement s = Database.getConnection().prepareStatement(SQL);
        int crm = Integer.parseInt(Scrm);
        s.setInt(1, crm);
        s.setString(2, nome);
        s.setString(3, email);
        s.setString(4, espec);
        s.setDate(5, nasc);
        s.setString(6, tel);
        s.setString(7, endereco);
        s.setString(8, cidade);
        s.setString(9, estado);
        s.execute();
        s.close();
    }
   
    public Medico(int id, int crm, String nome, String email, String espec, Date nasc, String telefone, String endereco, String cidade, String estado) {
        this.id = id;
        this.crm = crm;
        this.nome = nome;
        this.email = email;
        this.espec = espec;
        this.nasc = nasc;
        this.telefone = telefone;
        this.endereco = endereco;
        this.cidade = cidade;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCrm() {
        return crm;
    }

    public void setCrm(int crm) {
        this.crm = crm;
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

    public String getEspec() {
        return espec;
    }

    public void setEspec(String espec) {
        this.espec = espec;
    }

    public Date getNasc() {
        return nasc;
    }

    public void setNasc(Date nasc) {
        this.nasc = nasc;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
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
}
