package dao;

import java.sql.Connection;

public class TramiteFDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di TramiteFDAO
    public TramiteFDAO(Connection connection) {
        this.connection = connection;
    }
}