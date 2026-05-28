package model;

import java.math.BigDecimal;

public class Albergo {

    private String nomeAlbergo; //PK
    private String referente;
    private BigDecimal costoNotteOspite;
    private int numeroMassimoOspiti;
    private String indirizzo;
    private String telefono;
    private String fax;
    private String email;
    private String citta; //PK; FK verso Citta

}