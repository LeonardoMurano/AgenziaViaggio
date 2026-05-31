package model.dao;

import model.enums.Ruolo;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionFactory {

    /**classe con responsabilità di:
     * 1-creazione connessione al DB
     * 2-mantenimento della connessione globale
     * 3-cambio di connessione in base al ruolo
     * -----
     * la classe è singleton: viene creata un'unica connessione
     * condivisa da tutte le classi del software.
     */


    //DEFINIZIONE ATTRIBUTO IN CUI MEMORIZZARE LA CONNESSIONE AL DB
    //'static' serve a rendere connection con ambito di classe (globale)
    private static Connection connection;


    //COSTRUTTORE DI DEFAULT PRIVATO
    //serve a rendere strutturalmente impossibile la creazione di istanze di ConnectionFactory
    private ConnectionFactory() {}


    //BLOCCO DI CODICE ESEGUITO AL MOMENTO DEL CARICAMENTO DI ConnectionFactory IN MEMORIA
    //consente di inizializzare una connessione all'avvio, con ruolo di default CLIENTE
    static {
        initConnection(Ruolo.CLIENTE);
    }


    //METODO DI CREAZIONE FISICA DELLA CONNESSIONE AL DB
    //'private' rende il metodo invocabile solo da altri metodi della stessa classe
    private static void initConnection(Ruolo role) {

        //cerca "db.properties" nel classpath e lo apre come stream
        try (InputStream input =
                     ConnectionFactory.class.getClassLoader()
                             .getResourceAsStream("db.properties")) {

            //verifica che "db.properties" esista (per evitare NullPointerException)
            if (input == null) {
                throw new RuntimeException("db.properties non trovato nel classpath");
            }

            //lettura di "db.properties" riga per riga e mappatura
            Properties props = new Properties();
            props.load(input);

            //lettura dell'url del DB
            String url = props.getProperty("CONNECTION_URL");

            /**lettura dinamica delle credenziali:
             * >se role==CLIENTE allora legge credenziali inerenti CLIENTE
             * >se role==AGENTE allora legge credenziali inerenti AGENTE
             */
            String user = props.getProperty(role.name() + "_USER");
            String pass = props.getProperty(role.name() + "_PASS");

            //apertura connessione reale al DB
            connection = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            throw new RuntimeException("Errore connessione DB", e);
        }
    }

    //METODO DI ACCESSO ALLA CONNESSIONE CORRENTE
    //'public' lo rende invocabile da metodi di altre classi
    public static Connection getConnection() {
        return connection;
    }

    //METODO DI CAMBIO DEL RUOLO NEL DB
    //'public' lo rende invocabile da metodi di altre classi
    public static void changeRole(Ruolo role) throws SQLException {

        //chiusura connessione attuale
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }

        //creazione nuova connessione
        initConnection(role);
    }
}