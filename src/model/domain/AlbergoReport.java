package model.domain;

import java.math.BigDecimal;

public class AlbergoReport {

    //dichiarazione attributi dell'Albergo del viaggio
    String nomeAlbergo;
    BigDecimal costoNotteOspite;
    int durataTappa;
    BigDecimal costoAlbergoOspite;

    //dichiarazione costruttore di AlbergoReport
    public AlbergoReport(String nomeAlbergo, BigDecimal costoNotteOspite, int durataTappa) {
        this.nomeAlbergo = nomeAlbergo;
        this.costoNotteOspite = costoNotteOspite;
        this.durataTappa = durataTappa;
        //calcolo del costo totale dell'Albergo per ogni ospite
        costoAlbergoOspite = costoNotteOspite.multiply(BigDecimal.valueOf(durataTappa));
    }

    public String getNomeAlbergo() {return this.nomeAlbergo;}
    public int getDurataTappa() {return this.durataTappa;}
    public BigDecimal getCostoNotteOspite() {return  this.costoNotteOspite;}
    public BigDecimal getCostoAlbergoOspite() {return this.costoAlbergoOspite;}
}
