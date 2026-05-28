package model;

import java.time.LocalDate;

public class Prenotazione {

    private int idPrenotazione; //PK
    private int numeroOspitiPrenotazione;

    //FK verso Utente
    private String infoCliente;

    //FK verso EdizioneViaggioPassata
    private LocalDate partenzaP;
    private String itinerarioP;

    //FK verso EdizioneViaggioFutura
    private LocalDate partenzaF;
    private String itinerarioF;

}