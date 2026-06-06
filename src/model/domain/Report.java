package model.domain;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class Report {

    //dichiarazione attributi globali del report
    LocalDate dataPartenza;
    LocalDate dataRientro;
    int numeroOspitiTotale;
    BigDecimal costoOperativo;
    String itinerario;
    List<AutobusReport> autobusReport;

    //dichiarazione lista in cui inserire le informazioni del report inerenti ogni albergo
    private List<AlbergoReport> AlbergoReport;

    //dichiarazione lista in cui inserire le informazioni del report inerenti ogni cliente
    private List<UtenteReport> utenteReport;

    //definizione costruttore di Report
    public Report(LocalDate dataPartenza,
                  LocalDate dataRientro,
                  int numeroOspitiTotale,
                  BigDecimal costoOperativo,
                  String itinerario,
                  List<AutobusReport> autobusReport,
                  List<AlbergoReport> albergoReport,
                  List<UtenteReport> utenteReport) {
        this.dataPartenza = dataPartenza;
        this.dataRientro = dataRientro;
        this.numeroOspitiTotale = numeroOspitiTotale;
        this.costoOperativo = costoOperativo;
        this.itinerario = itinerario;
        this.autobusReport = autobusReport;
        this.AlbergoReport = albergoReport;
        this.utenteReport = utenteReport;
    }
}