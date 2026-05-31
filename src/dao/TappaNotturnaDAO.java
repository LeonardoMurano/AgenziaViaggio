package dao;

import java.sql.Connection;

public class TappaNotturnaDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di TappaNotturnaDAO
    public TappaNotturnaDAO(Connection connection) {
        this.connection = connection;
    }
}