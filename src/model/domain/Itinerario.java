package model.domain;

import java.math.BigDecimal;

public class Itinerario {


    //attributi classe Itinerario

    private final String nome;
    private BigDecimal costoItinerario;


    //costruttore per la creazione di nuovi oggetti 'Itinerario' e il mapping dal resultSet

    public Itinerario(String nome, BigDecimal costoItinerario) {

        this.nome = nome;
        this.costoItinerario = costoItinerario;
    }


    //operazioni di get

    public String getNome() {return nome;}
    public BigDecimal getCostoItinerario() {return costoItinerario;}
}
