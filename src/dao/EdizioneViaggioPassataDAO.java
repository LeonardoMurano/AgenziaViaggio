package dao;

import java.sql.Connection;

public class EdizioneViaggioPassataDAO {

    //riferimento alla connessione al DB da utilizzare
    private Connection connection;


    //costruttore di EdizioneViaggioPassataDAO
    public EdizioneViaggioPassataDAO(Connection connection) {
        this.connection = connection;
    }
}