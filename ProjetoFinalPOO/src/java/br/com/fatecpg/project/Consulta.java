package br.com.fatecpg.project;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Consulta {

   private int id;
   private String idMedico;
   private String idPaciente;
   private String hora;
   private Date data;
   private String motivo;
   private double valor;

   public static Consulta getConsulta(String idA) throws SQLException {
      String SQL = "SELECT * FROM consulta WHERE cd_consulta=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idA);
      s.setInt(1, id);
      ResultSet rs = s.executeQuery();
      Consulta c = null;
      if (rs.next()) {
         c = new Consulta(rs.getInt("cd_consulta"),
                 rs.getString("cd_medico"),
                 rs.getString("cd_paciente"),
                 rs.getString("hr_consulta"),
                 rs.getDate("dt_consulta"),
                 rs.getString("ds_motivo"),
                 rs.getDouble("vl_consulta"));
      }
      rs.close();
      s.close();
      return c;
   }

   public static Consulta checkConsulta(String cpf, String hora) throws SQLException {
      String SQL = "SELECT * FROM consulta WHERE cd_paciente=? AND hr_consulta=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);

      s.setString(1, hora);
      ResultSet rs = s.executeQuery();
      Consulta c = null;
      if (rs.next()) {
         c = new Consulta(rs.getInt("cd_consulta"),
                 rs.getString("cd_medico"),
                 rs.getString("cd_paciente"),
                 rs.getString("hr_consulta"),
                 rs.getDate("dt_consulta"),
                 rs.getString("ds_motivo"),
                 rs.getDouble("vl_consulta"));
      }
      rs.close();
      s.close();
      return c;
   }

   public static ArrayList<Consulta> getConsultaList() throws Exception {
      ArrayList<Consulta> list = new ArrayList<>();
      Statement s = Database.getConnection().createStatement();
      ResultSet rs = s.executeQuery("SELECT * FROM consulta ");
      while (rs.next()) {
         Consulta c = new Consulta(rs.getInt("cd_consulta"),
                 rs.getString("cd_medico"),
                 rs.getString("cd_paciente"),
                 rs.getString("hr_consulta"),
                 rs.getDate("dt_consulta"),
                 rs.getString("ds_motivo"),
                 rs.getDouble("vl_consulta"));
         list.add(c);
      }
      rs.close();
      s.close();
      return list;
   }

   public static void addConsulta(String idMedico, String idPaciente, String hora, Date data, String motivo, double valor) throws Exception {
      String SQL = "INSERT INTO consulta VALUES("
              + "default,?,?,?,?,?,?)";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setString(1, idMedico);
      s.setString(2, idPaciente);
      s.setString(3, hora);
      s.setDate(4, data);
      s.setString(5, motivo);
      s.setDouble(6, valor);
      s.execute();
      s.close();
   }

   public static void updateConsulta(String idMedico, String idPaciente, String hora, Date data,
           String motivo, double valor, String idS) throws Exception {
      String SQL = "UPDATE consulta"
              + " SET cd_medico=?, cd_paciente=?, hr_consulta=?,"
              + " dt_consulta=?, ds_motivo=?, vl_consulta"
              + " WHERE cd_consulta=?";

      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idS);
      s.setString(1, idMedico);
      s.setString(2, idPaciente);
      s.setString(3, hora);
      s.setDate(4, data);
      s.setString(5, motivo);
      s.setDouble(6, valor);
      s.setInt(7, id);
      s.execute();
      s.close();
   }

   public static void DeleteConsulta(String idS) throws SQLException {
      String SQL = "DELETE FROM consulta WHERE cd_consulta=?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idS);
      s.setInt(1, id);
      s.execute();
      s.close();
   }

   public Consulta(int id, String idMedico, String idPaciente, String hora, Date data, String motivo, double valor) {
      this.id = id;
      this.idMedico = idMedico;
      this.idPaciente = idPaciente;
      this.hora = hora;
      this.data = data;
      this.motivo = motivo;
      this.valor = valor;
   }

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public String getIdMedico() {
      return idMedico;
   }

   public void setIdMedico(String idMedico) {
      this.idMedico = idMedico;
   }

   public String getIdPaciente() {
      return idPaciente;
   }

   public void setIdPaciente(String idPaciente) {
      this.idPaciente = idPaciente;
   }

   public String getHora() {
      return hora;
   }

   public void setHora(String hora) {
      this.hora = hora;
   }

   public Date getData() {
      return data;
   }

   public void setData(Date data) {
      this.data = data;
   }

   public String getMotivo() {
      return motivo;
   }

   public void setMotivo(String motivo) {
      this.motivo = motivo;
   }

   public double getValor() {
      return valor;
   }

   public void setValor(double valor) {
      this.valor = valor;
   }

}
