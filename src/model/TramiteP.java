package model;

import java.time.LocalDate;

public class TramiteP {

    //PK; FK verso EdizioneViaggioPassata
    private LocalDate partenza;
    private String itinerario;

    //PK; FK verso AutobusAgenzia
    private int idMezzo;

}