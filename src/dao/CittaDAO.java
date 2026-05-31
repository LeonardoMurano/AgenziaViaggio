package dao;

import java.sql.Connection;

public class CittaDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di CittaDAO
    public CittaDAO(Connection connection) {
        this.connection = connection;
    }
}