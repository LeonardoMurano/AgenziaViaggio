package dao;

import java.sql.Connection;

public class AlloggioPDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di AlloggioPDAO
    public AlloggioPDAO(Connection connection) {
        this.connection = connection;
    }
}