package model;

import  java.time.LocalDate;
import java.math.BigDecimal;

public class EdizioneViaggioFutura {

    //attributi classe EdizioneViaggioFutura

    private LocalDate partenza;
    private LocalDate rientro;
    private int numeroOspitiTotale;
    private BigDecimal costoOperativo;
    private Itinerario itinerario;


    //costruttore per la creazione di nuovi oggetti 'Itinerario'

    public EdizioneViaggioFutura(LocalDate partenza,
                                 LocalDate rientro,
                                 BigDecimal costoOperativo,
                                 Itinerario itinerario) {
        this.partenza = partenza;
        this.rientro = rientro;
        this.costoOperativo = costoOperativo;
        this.itinerario = itinerario;
        //alla creazione, EdizioneViaggioFutura.numeroOspitiTotale==0 sempre
        this.numeroOspitiTotale = 0;
    }


    //costruttore per il mapping dal resultSet

    public EdizioneViaggioFutura(LocalDate partenza,
                                 LocalDate rientro,
                                 int numeroOspitiTotale,
                                 BigDecimal costoOperativo,
                                 Itinerario itinerario) {
        this.partenza = partenza;
        this.rientro = rientro;
        this.costoOperativo = costoOperativo;
        this.itinerario = itinerario;
        this.numeroOspitiTotale = numeroOspitiTotale;
    }


    //operazioni di get

    public LocalDate getPartenza() {return partenza;}
    public LocalDate getRientro() {return rientro;}
    public int getNumeroOspitiTotale() {return numeroOspitiTotale;}
    public BigDecimal getCostoOperativo() {return costoOperativo;}
    public Itinerario getItinerario() {return itinerario;}


    //operazioni di set

    public void setNumeroOspitiTotale(int numeroOspitiTotale) {
        this.numeroOspitiTotale = numeroOspitiTotale;
    }
}