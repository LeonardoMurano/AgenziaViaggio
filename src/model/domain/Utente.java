package model.domain;

import model.enums.Ruolo;

public class Utente {


    //attributi classe Utente

    private final String username;
    private String nomeUtente;
    private String cognomeUtente;
    private String password;
    private Ruolo ruolo;


    //costruttore per la creazione di nuovi oggetti 'Utente' e il mapping dal resultSet

    public Utente(String username,
                  String nomeUtente,
                  String cognomeUtente,
                  String password,
                  Ruolo ruolo) {

        this.username = username;
        this.nomeUtente = nomeUtente;
        this.cognomeUtente = cognomeUtente;
        this.password = password;
        this.ruolo = ruolo;
    }


    //costruttore per la creazione di nuovi oggetti 'Utente' in fase di login

    public Utente(String username,
                  String password,
                  Ruolo ruolo) {

        this.username = username;
        this.password = password;
        this.ruolo = ruolo;
        this.nomeUtente = null;
        this.cognomeUtente = null;
    }


    //operazioni di get

    public String getUsername() {return username;}
    public String getNomeUtente() {return nomeUtente;}
    public String getCognomeUtente() {return cognomeUtente;}
    public String getPassword() {return password;}
    public Ruolo getRuolo() {return ruolo;}
}
