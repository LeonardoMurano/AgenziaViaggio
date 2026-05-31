package dao;

import java.sql.Connection;

public class UtenteDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di UtenteDAO
    public UtenteDAO(Connection connection) {
        this.connection = connection;
    }
}