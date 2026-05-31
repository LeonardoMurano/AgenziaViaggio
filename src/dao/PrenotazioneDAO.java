package dao;

import java.sql.Connection;

public class PrenotazioneDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di PrenotazioneDAO
    public PrenotazioneDAO(Connection connection) {
        this.connection = connection;
    }
}