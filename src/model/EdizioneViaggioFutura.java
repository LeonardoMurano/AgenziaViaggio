package model;

import  java.time.LocalDate;
import java.math.BigDecimal;

public class EdizioneViaggioFutura {

    private LocalDate partenza; //PK
    private LocalDate rientro;
    private int numeroOspitiTotale;
    private BigDecimal costoOperativo;
    private String itinerario; //PK; FK verso Itinerario

}