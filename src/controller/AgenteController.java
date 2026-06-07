/**Classe con responsabilità di controllo e coordinamento del flusso di esecuzione dell'applicazione
 * nel caso di utente autenticato con ruolo 'Agente'
 */
package controller;

import exception.ApplicationException;
import exception.ControllerException;
import exception.DAOException;
import model.dao.*;
import model.domain.AutobusAssociatiEdizioneViaggio;
import model.domain.Report;
import model.dto.*;
import view.AgenteView;
import model.domain.Ruolo;

import java.sql.SQLException;

public class AgenteController implements Controller {

    //creazione istanza di AgenteView
    private final AgenteView view = new AgenteView();


    //FUNZIONE DI AVVIO DELL'AgenteController
    @Override
    public void start() throws ApplicationException {

        //effettua il cambio di ruolo LOGIN->AGENTE
        try {
            ConnectionFactory.changeRole(Ruolo.AGENTE);
        } catch (SQLException e) {
            throw new ApplicationException(e.getMessage(), e);
        }

        //inizializzazione ciclo infinito
        while (true) {

            //invoca funzione per mostrare in output il menù di Agente
            int choice = view.showMenu();

            //in base all'input ricevuto, esegue una diversa operazione di Agente
            try {
                switch (choice) {
                    case 1 -> RegistraItinerario();
                    case 2 -> RegistraEdizioneViaggio();
                    case 3 -> RegistraAlbergo();
                    case 4 -> RegistraAutobusAgenzia();
                    case 5 -> AssociaAutobusAgenzia();
                    case 6 -> AssociaAlbergo();
                    case 7 -> ReportEdizioneViaggio();
                    case 8 -> System.exit(0);
                    default -> throw new ControllerException("Scelta non valida");
                }

                //gestione errori nello switch
            } catch (ControllerException e) {
                view.showError(e.getMessage());
            }
        }
    }


//DEFINIZIONE DI UNA FUNZIONE PER IL CONTROLLO DELL'ESECUZIONE DI OGNI OPERAZIONE SU CUI AGENTE HA GRANT




    void  RegistraItinerario() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        RegistraItinerarioRequest request = view.registraItinerarioRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try {
            //esecuzione procedura di registrazione itinerario
            new RegistraItinerarioProceduraDAO().execute(request);
            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoRegistrazioneItinerario();

        } catch (DAOException e) {
            //gestione errori nella procedura di registrazione itinerario
            throw new ControllerException(e.getMessage(), e);
        }
    }


    void  RegistraEdizioneViaggio() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        RegistraEdizioneViaggioRequest request = view.registraEdizioneViaggioRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try{
            //esecuzione procedura di registrazione EdizioneViaggio
            new RegistraEdizioneViaggioProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoRegistrazioneEdizioneViaggio();

        } catch (DAOException e) {
            //gestione errori nella procedura di registrazione edizione di viaggio
            throw new ControllerException(e.getMessage(), e);
        }
    }


    void  RegistraAlbergo() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        RegistraAlbergoRequest request = view.registraAlbergoRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try{
            //esecuzione procedura di registrazione Albergo
            new RegistraAlbergoProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoRegistrazioneAlbergo();

        } catch (DAOException e) {
            //gestione errori nella procedura di registrazione albergo
            throw new ControllerException(e.getMessage(), e);
        }
    }


    void  RegistraAutobusAgenzia() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        RegistraAutobusAgenziaRequest request = view.registraAutobusAgenziaRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try{
            //esecuzione procedura di registrazione AutobusAgenzia
            int idMezzo = new RegistraAutobusAgenziaProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaIdMezzo(idMezzo);

        } catch (DAOException e) {
            //gestione errori nella procedura di registrazione AutobusAgenzia
            throw new ControllerException(e.getMessage(), e);
        }
    }


    void  AssociaAutobusAgenzia() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        AssociaAutobusAgenziaRequest request = view.associaAutobusAgenziaRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try{
            //esecuzione procedura di associazione AutobusAgenzia
            AutobusAssociatiEdizioneViaggio output = new AssociaAutobusAgenziaProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoAssociazioneAutobusAgenzia(output);

        } catch (DAOException e) {
            //gestione errori nella procedura di associazione AutobusAgenzia
            throw new ControllerException(e.getMessage(), e);
        }
    }


    void  AssociaAlbergo() throws ControllerException {

        //invoca AgenteView per richiede i dati in input all'agente
        AssociaAlbergoRequest request = view.associaAlbergoRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try{
            //esecuzione procedura di associazione Albergo
            new AssociaAlbergoProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoAssociazioneAlbergo();

        } catch (DAOException e) {
            //gestione errori nella procedura di associazione Albergo
            throw new ControllerException(e.getMessage(), e);
        }

    }


    void  ReportEdizioneViaggio() throws ControllerException {

        //invoca AgenteView per richiedere i dati in input all'agente
        GeneraReportRequest request = view.generaReportRichiedi();

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}
        try {
            //esecuzione procedura di generazione del report
            Report report = new CostruisciReportProceduraDAO().execute(request);

            //invoca funzione di stampa a schermo del report generato
            view.visualizzaReport(report);

        } catch (DAOException e) {
            //gestione errori nella procedura di generazione report
            throw new ControllerException(e.getMessage(), e);
        }

    }
}

