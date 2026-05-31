package dao;

import java.sql.Connection;

public class AlloggioFDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di AlloggioFDAO
    public AlloggioFDAO(Connection connection) {
        this.connection = connection;
    }
}