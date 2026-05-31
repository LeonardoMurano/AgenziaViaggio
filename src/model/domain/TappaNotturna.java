package model.domain;

public class TappaNotturna {


    //attributi classe TappaNotturna

    private int numero;
    private int durataTappa;
    private Itinerario itinerario;
    private Citta citta;


    //costruttore per la creazione di nuovi oggetti 'TappaNotturna' e il mapping dal resultSet

    public TappaNotturna(int numero,
                         int durataTappa,
                         Itinerario itinerario,
                         Citta citta) {
        this.numero = numero;
        this.durataTappa = durataTappa;
        this.itinerario = itinerario;
        this.citta = citta;
    }


    //operazioni di get

    public int getNumero() {return numero;}
    public int  getDurataTappa() {return durataTappa;}
    public Itinerario getItinerario() {return itinerario;}
    public Citta getCitta() {return citta;}
}