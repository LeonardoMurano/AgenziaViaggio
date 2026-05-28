package model;

public class TappaNotturna {

    private int numero; //PK
    private int durataTappa;
    private String itinerario; //PK; FK verso Itinerario
    private String citta; //FK verso Citta

}