package dao;

import java.sql.Connection;

public class ItinerarioDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di ItinerarioDAO
    public ItinerarioDAO(Connection connection) {
        this.connection = connection;
    }
}