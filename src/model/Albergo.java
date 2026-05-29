package model;

import java.math.BigDecimal;

public class Albergo {


    //attributi classe Albergo

    private final String nomeAlbergo;
    private String referente;
    private BigDecimal costoNotteOspite;
    private int numeroMassimoOspiti;
    private String indirizzo;
    private String telefono;
    private String fax;
    private String email;
    private final Citta citta;


    //costruttore per la creazione di nuovi oggetti 'Albergo' e il mapping dal resultSet

    public Albergo(String nomeAlbergo,
                   String referente,
                   BigDecimal costoNotteOspite,
                   int numeroMassimoOspiti,
                   String indirizzo,
                   String telefono,
                   String fax,
                   String email,
                   Citta citta) {

        this.nomeAlbergo = nomeAlbergo;
        this.referente = referente;
        this.costoNotteOspite = costoNotteOspite;
        this.numeroMassimoOspiti = numeroMassimoOspiti;
        this.indirizzo = indirizzo;
        this.telefono = telefono;
        this.fax = fax;
        this.email = email;
        this.citta = citta;
    }


    //operazioni di get

    public String getNomeAlbergo() {return nomeAlbergo;}
    public String getReferente() {return referente;}
    public BigDecimal getCostoNotteOspite() {return costoNotteOspite;}
    public int getNumeroMassimoOspiti() {return numeroMassimoOspiti;}
    public String getIndirizzo() {return indirizzo;}
    public String getTelefono() {return telefono;}
    public String getFax() {return fax;}
    public String getEmail() {return email;}
    public Citta getCitta() {return citta;}
}