package br.com.fatecpg.project;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Consulta {

   private int id;
   private int idMedico;
   private int idPaciente;
   private Date hora;
   private Date data;
   private String motivo;
   private double valor;

   public static Consulta getConsulta(String idA) throws SQLException {
      String SQL = "SELECT * FROM consulta WHERE cd_consulta=? ORDER BY dt_consulta DESC";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idA);
      s.setInt(1, id);
      ResultSet rs = s.executeQuery();
      Consulta c = null;
      if (rs.next()) {
         c = new Consulta(rs.getInt("cd_consulta"),
                 rs.getInt("cd_medico"),
                 rs.getInt("cd_paciente"),
                 rs.getDate("hr_consulta"),
                 rs.getDate("dt_consulta"),
                 rs.getString("ds_motivo"),
                 rs.getDouble("vl_consulta"));

      }
      rs.close();
      s.close();
      return c;
   }

   public static void addConsulta(int idMedico, int idPaciente, Date hora, Date data, String motivo, double valor) throws Exception {
      String SQL = "INSERT INTO consulta VALUES("
              + "default,?,?,?,?,?,?)";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      s.setInt(1, idMedico);
      s.setInt(2, idPaciente);
      s.setDate(3, hora);
      s.setDate(4, data);
      s.setString(5, motivo);
      s.setDouble(6, valor);
      s.execute();
      s.close();
   }

   public Consulta(int id, int idMedico, int idPaciente, Date hora, Date data, String motivo, double valor) {
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

   public int getIdMedico() {
      return idMedico;
   }

   public void setIdMedico(int idMedico) {
      this.idMedico = idMedico;
   }

   public int getIdPaciente() {
      return idPaciente;
   }

   public void setIdPaciente(int idPaciente) {
      this.idPaciente = idPaciente;
   }

   public Date getHora() {
      return hora;
   }

   public void setHora(Date hora) {
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
