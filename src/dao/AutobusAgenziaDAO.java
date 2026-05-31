package dao;

import java.sql.Connection;

public class AutobusAgenziaDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di AutobusAgenziaDAO
    public AutobusAgenziaDAO(Connection connection) {
        this.connection = connection;
    }
}