package model;

import java.time.LocalDate;

public class Prenotazione {


    //attributi classe Prenotazione

    private int idPrenotazione;
    private int numeroOspitiPrenotazione;
    private Utente utente;
    private EdizioneViaggioPassata edizioneViaggioPassata;
    private EdizioneViaggioFutura edizioneViaggioFutura;


    //costruttore per la creazione di nuovi oggetti 'Prenotazione'

    public Prenotazione(int numeroOspitiPrenotazione,
                        Utente utente,
                        EdizioneViaggioPassata edizioneViaggioPassata,
                        EdizioneViaggioFutura edizioneViaggioFutura) {
        //al momento della creazione, idPrenotazione è autogenerato dal DB
        this.numeroOspitiPrenotazione = numeroOspitiPrenotazione;
        this.utente = utente;
        this.edizioneViaggioPassata = edizioneViaggioPassata;
        this.edizioneViaggioFutura = edizioneViaggioFutura;
    }


    //costruttore per il mapping dal resultSet

    public Prenotazione(int idPrenotazione,
                        int numeroOspitiPrenotazione,
                        Utente utente,
                        EdizioneViaggioPassata edizioneViaggioPassata,
                        EdizioneViaggioFutura edizioneViaggioFutura) {
        //deve sempre essere verificato:
        //(edizioneViaggioPassata==NULL)XOR(edizioneViaggioFutura==NULL)
        this.idPrenotazione = idPrenotazione;
        this.numeroOspitiPrenotazione = numeroOspitiPrenotazione;
        this.utente = utente;
        this.edizioneViaggioPassata = edizioneViaggioPassata;
        this.edizioneViaggioFutura = edizioneViaggioFutura;
    }


    //operazioni di get

    public int getIdPrenotazione() {return idPrenotazione;}
    public int getNumeroOspitiPrenotazione() {return numeroOspitiPrenotazione;}
    public Utente getUtente() {return utente;}
    public EdizioneViaggioPassata getEdizioneViaggioPassata() {return edizioneViaggioPassata;}
    public EdizioneViaggioFutura getEdizioneViaggioFutura() {return edizioneViaggioFutura;}
}