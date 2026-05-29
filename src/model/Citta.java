package model;

public class Citta {


    //attributi classe Citta

    private final String nomeCitta;


    //costruttore per la creazione di nuovi oggetti 'Citta' e il mapping dal resultSet

    public Citta(String nomeCitta) {
        this.nomeCitta = nomeCitta;
    }


    //operazioni di get

    public String getNomeCitta() {return nomeCitta;}
}