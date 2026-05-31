package dao;

import java.sql.Connection;

public class TramitePDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di TramitePDAO
    public TramitePDAO(Connection connection) {
        this.connection = connection;
    }
}