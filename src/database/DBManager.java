package database;

import java.sql.Connection;     //consente connessione attiva al DB
import java.sql.DriverManager;  //gestisce i driver JDBC e crea le connessioni
import java.sql.SQLException;   //eccezione lanciata nel caso di errori nel DB

public class DBManager {

    //classe con responsabilità di gestione della connessione al DB

    private static final String URL = "jdbc:mysql://localhost:3306/AgenziaViaggio";
    private static final String USER = "root";
    private static final String PASSWORD = "Leonardo2004";

    public static Connection getConnection()
            throws SQLException {

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}