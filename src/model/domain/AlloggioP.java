package model.domain;

public class AlloggioP {


    //attributi classe AlloggioP

    private final EdizioneViaggioPassata edizioneViaggioPassata;
    private final TappaNotturna tappaNotturna;
    private Albergo albergo;


    //costruttore per la creazione di nuovi oggetti 'AlloggioP' e il mapping dal resultSet

    public AlloggioP(EdizioneViaggioPassata edizioneViaggioPassata,
                     TappaNotturna tappaNotturna,
                     Albergo albergo) {
        this.edizioneViaggioPassata = edizioneViaggioPassata;
        this.tappaNotturna = tappaNotturna;
        this.albergo = albergo;
    }


    //operazioni di get

    public EdizioneViaggioPassata getEdizioneViaggioPassata() {return edizioneViaggioPassata;}
    public TappaNotturna getTappaNotturna() {return tappaNotturna;}
    public Albergo getAlbergo() {return albergo;}
}