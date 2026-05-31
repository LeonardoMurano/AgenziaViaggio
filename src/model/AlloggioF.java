package model;

public class AlloggioF {


    //attributi classe AlloggioF

    private final EdizioneViaggioFutura edizioneViaggioFutura;
    private final TappaNotturna tappaNotturna;
    private Albergo albergo;


    //costruttore per la creazione di nuovi oggetti 'AlloggioF' e il mapping dal resultSet

    public AlloggioF(EdizioneViaggioFutura edizioneViaggioFutura,
                     TappaNotturna tappaNotturna,
                     Albergo albergo) {
        this.edizioneViaggioFutura = edizioneViaggioFutura;
        this.tappaNotturna = tappaNotturna;
        this.albergo = albergo;
    }


    //operazioni di get

    public EdizioneViaggioFutura getEdizioneViaggioFutura() {return edizioneViaggioFutura;}
    public TappaNotturna getTappaNotturna() {return tappaNotturna;}
    public Albergo getAlbergo() {return albergo;}
}