package model.domain;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

public class Report {

    //dichiarazione attributi globali del report
    private LocalDate dataPartenza;
    private LocalDate dataRientro;
    private int numeroOspitiTotale;
    private BigDecimal costoOperativo;
    private BigDecimal costoItinerario;
    private String itinerario;

    //dichiarazione attributi globali derivati del report
    private int totaleOspiti;
    private BigDecimal costoTotalePerOspite;
    private BigDecimal costoTotaleViaggio;
    private BigDecimal guadagnoAgenzia;

    //dichiarazione lista in cui inserire le informazioni del report inerenti ogni autobus
    private List<AutobusReport> autobusReport;
    //dichiarazione lista in cui inserire le informazioni del report inerenti ogni albergo
    private List<AlbergoReport> albergoReport;
    //dichiarazione lista in cui inserire le informazioni del report inerenti ogni cliente
    private List<UtenteReport> utenteReport;


    //definizione costruttore di Report
    public Report(LocalDate dataPartenza,
                  LocalDate dataRientro,
                  int numeroOspitiTotale,
                  BigDecimal costoOperativo,
                  BigDecimal costoItinerario,
                  String itinerario,
                  List<AutobusReport> autobusReport,
                  List<AlbergoReport> albergoReport,
                  List<UtenteReport> utenteReport) {
        this.dataPartenza = dataPartenza;
        this.dataRientro = dataRientro;
        this.numeroOspitiTotale = numeroOspitiTotale;
        this.costoOperativo = costoOperativo;
        this.costoItinerario = costoItinerario;
        this.itinerario = itinerario;
        this.autobusReport = autobusReport;
        this.albergoReport = albergoReport;
        this.utenteReport = utenteReport;
        //invocazione funzione di calcolo attributi derivati
        calcolaDerivati();
    }

    //definizione metodo di calcolo attributi derivati
    private void calcolaDerivati() {

        //calcolo del numero totale di ospiti
        this.totaleOspiti = utenteReport.stream()
                .mapToInt(UtenteReport::getNumeroOspitiPrenotazione)
                .sum();

        //gestione del caso in cui totaleOspiti == 0
        if (totaleOspiti == 0) {
            this.costoTotalePerOspite = BigDecimal.ZERO;
            this.costoTotaleViaggio = BigDecimal.ZERO;
            this.guadagnoAgenzia = BigDecimal.ZERO;
            return;
        }

        //calcolo del costo totale degli alberghi ad ospite
        BigDecimal costoAlbergoPerOspiteTotale = albergoReport.stream()
                .map(AlbergoReport::getCostoAlbergoOspite)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        //calcolo del costo totale degli alberghi
        BigDecimal costoAlbergoTotale =
                costoAlbergoPerOspiteTotale.multiply(BigDecimal.valueOf(totaleOspiti));

        //calcolo del costo totale degli autobus
        BigDecimal costoAutobusTotale = autobusReport.stream()
                .map(AutobusReport::getCostoMezzo)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        //calcolo del ricavo totale ottenuto nell'EdizioneViaggioPassata
        this.costoTotaleViaggio =
                costoAlbergoTotale.add(costoAutobusTotale).add(costoItinerario);

        //calcolo del costo finale per ospite
        this.costoTotalePerOspite =
                costoTotaleViaggio.divide(BigDecimal.valueOf(totaleOspiti), 2, RoundingMode.HALF_UP);

        //calcolo del guadagno totale ottenuto nell'EdizioneViaggioPassata
        this.guadagnoAgenzia =
                costoTotaleViaggio.subtract(costoOperativo);
    }


    //definizione metodo di costruzione del Report
    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        sb.append("\n*** REPORT VIAGGIO ***\n");
        sb.append("Itinerario: ").append(itinerario).append("\n");
        sb.append("Partenza: ").append(dataPartenza).append("\n");
        sb.append("Rientro: ").append(dataRientro).append("\n");
        sb.append("Ospiti: ").append(numeroOspitiTotale).append("\n\n");

        sb.append(">>> UTENTI\n");
        utenteReport.forEach(u ->
                sb.append("Username: ").append(u.getUsername())
                        .append(", Nome: ").append(u.getNomeUtente())
                        .append(", Cognome: ").append(u.getCognomeUtente())
                        .append(", ID Prenotazione: ").append(u.getIdPrenotazione())
                        .append(", Numero ospiti prenotazione: ").append(u.getNumeroOspitiPrenotazione())
                        .append("\n")
        );

        sb.append("\n>>> ALBERGHI\n");
        albergoReport.forEach(a ->
                sb.append("Nome Albergo: ").append(a.getNomeAlbergo())
                        .append(", Costo a notte per ospite: ").append(a.getCostoNotteOspite())
                        .append(", Durata tappa: ").append(a.getDurataTappa())
                        .append("\n")
        );

        sb.append("\n>>> AUTOBUS\n");
        autobusReport.forEach(a ->
                sb.append("ID Mezzo: ").append(a.getIdMezzo())
                        .append(", Costo mezzo: ").append(a.getCostoMezzo())
                        .append("\n")
        );

        sb.append("\n--- DATI FINALI ---\n");
        sb.append("Costo totale per ospite: ").append(costoTotalePerOspite).append("\n");
        sb.append("Costo totale viaggio: ").append(costoTotaleViaggio).append("\n");
        sb.append("Guadagno agenzia: ").append(guadagnoAgenzia).append("\n");

        return sb.toString();
    }
}