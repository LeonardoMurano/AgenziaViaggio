package dao;

import java.sql.Connection;

public class AlbergoDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di AlbergoDAO
    public AlbergoDAO(Connection connection) {
        this.connection = connection;
    }
}