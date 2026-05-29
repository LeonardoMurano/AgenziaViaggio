package model;

import  java.time.LocalDate;
import java.math.BigDecimal;

public class EdizioneViaggioPassata {

    //attributi classe EdizioneViaggioPassata

    private LocalDate partenza;
    private LocalDate rientro;
    private int numeroOspitiTotale;
    private BigDecimal costoOperativo;
    private Itinerario itinerario;


    //costruttore per la creazione di nuovi oggetti 'EdizioneViaggioPassata'  e il mapping dal resultSet

    public EdizioneViaggioPassata(LocalDate partenza,
                                  LocalDate rientro,
                                  int  numeroOspitiTotale,
                                  BigDecimal costoOperativo,
                                  Itinerario itinerario) {

        this.partenza = partenza;
        this.rientro = rientro;
        this.numeroOspitiTotale = numeroOspitiTotale;
        this.costoOperativo = costoOperativo;
        this.itinerario = itinerario;
    }


    //operazioni di get

    public LocalDate getPartenza() {return partenza;}
    public LocalDate getRientro() {return rientro;}
    public int getNumeroOspitiTotale() {return numeroOspitiTotale;}
    public BigDecimal getCostoOperativo() {return costoOperativo;}
    public Itinerario getItinerario() {return itinerario;}
}