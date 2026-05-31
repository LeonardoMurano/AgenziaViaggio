package model;

public class TramiteF {


    //attributi classe TramiteF

    private EdizioneViaggioFutura edizioneViaggioFutura;
    private AutobusAgenzia autobusAgenzia;


    //costruttore per la creazione di nuovi oggetti 'TramiteF' e il mapping dal resultSet

    public TramiteF(EdizioneViaggioFutura edizioneViaggioFutura,
                    AutobusAgenzia autobusAgenzia) {
        this.edizioneViaggioFutura = edizioneViaggioFutura;
        this.autobusAgenzia = autobusAgenzia;
    }


    //operazioni di get

    public EdizioneViaggioFutura getEdizioneViaggioFutura() {return edizioneViaggioFutura;}
    public AutobusAgenzia getAutobusAgenzia() {return autobusAgenzia;}
}