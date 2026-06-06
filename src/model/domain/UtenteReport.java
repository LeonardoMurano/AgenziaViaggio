package model.domain;

public class UtenteReport {

    //dichiarazione attributi degli utenti prenotati al viaggio
    String username;
    String nomeUtente;
    String cognomeUtente;
    int idPrenotazione;
    int numeroOspitiPrenotazione;

    //dichiarazione costruttore di UtenteReport
    public UtenteReport(String username,
                        String nomeUtente,
                        String cognomeUtente,
                        int idPrenotazione,
                        int numeroOspitePrenotazione) {
        this.username = username;
        this.nomeUtente = nomeUtente;
        this.cognomeUtente = cognomeUtente;
        this.idPrenotazione = idPrenotazione;
        this.numeroOspitiPrenotazione = numeroOspitePrenotazione;
    }
}
