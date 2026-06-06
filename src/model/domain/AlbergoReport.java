package model.domain;

import java.math.BigDecimal;

public class AlbergoReport {

    //dichiarazione attributi dell'Albergo del viaggio
    String nomeAlbergo;
    BigDecimal costoNotteOspite;

    //dichiarazione costruttore di AlbergoReport
    public AlbergoReport(String nomeAlbergo, BigDecimal costoNotteOspite) {
        this.nomeAlbergo = nomeAlbergo;
        this.costoNotteOspite = costoNotteOspite;
    }
}
