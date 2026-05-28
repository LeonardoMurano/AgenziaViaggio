package model;

import java.time.LocalDate;

public class AlloggioF {

    //PK; FK verso EdizioneViaggioPassata
    private LocalDate edizioneViaggio;
    private String itinerarioViaggio;

    //PK; FK verso TappaNotturna
    private int tappaNotturna;
    private String itinerarioTappa;

    //FK verso Albergo
    private String nomeAlbergo;
    private String citta;

}
