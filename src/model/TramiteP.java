package model;

public class TramiteP {


    //attributi classe TramiteP

    private EdizioneViaggioPassata edizioneViaggioPassata;
    private AutobusAgenzia autobusAgenzia;


    //costruttore per la creazione di nuovi oggetti 'TramiteP' e il mapping dal resultSet

    public TramiteP(EdizioneViaggioPassata edizioneViaggioPassata,
                    AutobusAgenzia autobusAgenzia) {
        this.edizioneViaggioPassata = edizioneViaggioPassata;
        this.autobusAgenzia = autobusAgenzia;
    }


    //operazioni di get

    public EdizioneViaggioPassata getEdizioneViaggioPassata() {return edizioneViaggioPassata;}
    public AutobusAgenzia getAutobusAgenzia() {return autobusAgenzia;}
}