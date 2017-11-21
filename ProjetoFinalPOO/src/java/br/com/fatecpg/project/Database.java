package br.com.fatecpg.project;
import java.sql.DriverManager;
import java.sql.Connection;

public class Database {
    private static Connection connection;
    private static Exception connectionException;
    
    public static Connection getConnection(){
        if(connection == null){
            try{
                Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
                String url = "jdbc:derby:c:/derby/ProjetoHealthcare;create=true";
                connection = DriverManager.getConnection(url);
                connectionException = null;
            }catch(Exception ex){
                connection = null;
                connectionException = ex;
            }
        }
        return connection;
    }
    
    public static Exception getConnectionException(){
        return connectionException;
    }
}