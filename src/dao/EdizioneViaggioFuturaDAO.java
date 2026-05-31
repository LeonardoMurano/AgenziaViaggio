package dao;

import java.sql.Connection;

public class EdizioneViaggioFuturaDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di EdizioneViaggioFuturaDAO
    public EdizioneViaggioFuturaDAO(Connection connection) {
        this.connection = connection;
    }
}