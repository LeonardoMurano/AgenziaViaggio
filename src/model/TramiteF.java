package model;

import java.time.LocalDate;

public class TramiteF {

    //PK; FK verso EdizioneViaggioFutura
    private LocalDate partenza;
    private String itinerario;

    //PK; FK verso AutobusAgenzia
    private int idMezzo;

}