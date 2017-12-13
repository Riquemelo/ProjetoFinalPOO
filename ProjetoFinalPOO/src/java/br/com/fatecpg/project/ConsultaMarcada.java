package br.com.fatecpg.project;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ConsultaMarcada {

   private String nome;
   private String hr;
   private Date data;
   private String motivo;
   private Double valor;

   public ConsultaMarcada(String nome, String hr, Date data, String motivo, Double valor) {
      this.nome = nome;
      this.hr = hr;
      this.data = data;
      this.motivo = motivo;
      this.valor = valor;
   }

   public static ConsultaMarcada getConsultaMarcada(String idA) throws SQLException {
      String SQL = "SELECT * "
              + "FROM consulta, paciente "
              + "WHERE cd_medico =?";
      PreparedStatement s = Database.getConnection().prepareStatement(SQL);
      int id = Integer.parseInt(idA);
      s.setInt(1, id);
      ResultSet rs = s.executeQuery();
      ConsultaMarcada c = null;
      if (rs.next()) {
         c = new ConsultaMarcada(rs.getString("nm_name"),
                 rs.getString("hr_consulta"),
                 rs.getDate("dt_consulta"),
                 rs.getString("ds_motivo"),
                 rs.getDouble("vl_consulta"));

      }
      rs.close();
      s.close();
      return c;
   }

   public static ArrayList<ConsultaMarcada> getConsultaMarcadaList() throws Exception {
      ArrayList<ConsultaMarcada> list = new ArrayList<>();
      Statement s = Database.getConnection().createStatement();
      ResultSet rs = s.executeQuery("SELECT consulta.cd_medico, consulta.cd_paciente, consulta.hr_consulta, "
              + "consulta.dt_consulta, consulta.ds_motivo,"
              + "consulta.vl_consulta, "
              + "paciente.cd_cpf, paciente.nm_name"
              + "FROM consulta, paciente "
              + "WHERE cd_medico =?");
      while (rs.next()) {
         ConsultaMarcada c = new ConsultaMarcada(rs.getString("nm_name"),
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

   public String getNome() {
      return nome;
   }

   public String getHr() {
      return hr;
   }

   public Date getData() {
      return data;
   }

   public String getMotivo() {
      return motivo;
   }

   public Double getValor() {
      return valor;
   }

   public void setNome(String nome) {
      this.nome = nome;
   }

   public void setHr(String hr) {
      this.hr = hr;
   }

   public void setData(Date data) {
      this.data = data;
   }

   public void setMotivo(String motivo) {
      this.motivo = motivo;
   }

   public void setValor(Double valor) {
      this.valor = valor;
   }

}
