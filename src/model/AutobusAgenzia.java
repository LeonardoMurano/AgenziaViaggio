package model;

import java.math.BigDecimal;

public class AutobusAgenzia {


    //attributi classe AutobusAgenzia

    private int idMezzo;
    private BigDecimal costoMezzo;
    private int capienza;


    //costruttore per la creazione di nuovi oggetti 'Utente'

    public AutobusAgenzia(BigDecimal costoMezzo, int capienza) {

        //al momento della creazione, idMezzo è autogenerato dal DB
        this.costoMezzo = costoMezzo;
        this.capienza = capienza;
    }


    //costruttore per il mapping dal resultSet

    public AutobusAgenzia(int idMezzo, BigDecimal costoMezzo, int capienza) {

        this.idMezzo = idMezzo;
        this.costoMezzo = costoMezzo;
        this.capienza = capienza;
    }


    //operazioni di get

    public int getIdMezzo() {return idMezzo;}
    public BigDecimal getCostoMezzo() {return costoMezzo;}
    public int getCapienza() {return capienza;}
}