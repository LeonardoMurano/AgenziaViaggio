package model.domain;

import java.math.BigDecimal;

public class AutobusReport {

    //dichiarazione attributi dell'Autobus del viaggio
    int idMezzo;
    BigDecimal costoMezzo;

    //definizione costruttore AutobusReport
    public AutobusReport(int idMezzo, BigDecimal costoMezzo) {
        this.idMezzo = idMezzo;
        this.costoMezzo = costoMezzo;
    }
}
