/**Classe con responsabilità di controllo e coordinamento del flusso di esecuzione dell'applicazione
 * nel caso di utente autenticato con ruolo 'Cliente'
 */
package controller;

import exception.ApplicationException;
import exception.ControllerException;
import exception.DAOException;
import model.dao.CancellaPrenotazioneProceduraDAO;
import model.dao.ConnectionFactory;
import model.dao.RegistraPrenotazioneProceduraDAO;
import model.domain.Utente;
import model.dto.CancellaPrenotazioneRequest;
import model.dto.RegistraPrenotazioneRequest;
import view.ClienteView;
import model.enums.Ruolo;

import java.sql.SQLException;

public class ClienteController implements Controller {

    //DICHIARAZIONE ATTRIBUTO IN CUI SONO MEMORIZZATE LE CREDENZIALI DI Cliente (Username; Password)
    //necessario perchè le operazioni su cui Cliente possiede grant
    //richiedono di tenere traccia del Cliente che le esegue
    Utente cred;

    //creazione istanza di ClienteView e memorizzazione del suo riferimento in 'view'
    private final ClienteView view = new ClienteView();


    //COSTRUTTORE DELLA CLASSE ClienteController
    public ClienteController(Utente cred) {
        this.cred = cred;
    }


    //FUNZIONE DI AVVIO DEL ClienteController
    @Override
    public void start() throws ApplicationException {

        //effettua il cambio di ruolo LOGIN->CLIENTE
        try {
            ConnectionFactory.changeRole(Ruolo.CLIENTE);
        } catch (SQLException e) {
            throw new ApplicationException(e.getMessage(), e);
        }

        //inizializzazione ciclo infinito
        while (true) {

            //invoca funzione per mostrare in output il menù di Cliente
            int choice = view.showMenu();

            //in base all'input ricevuto, esegue una diversa operazione di Cliente
            try {
                switch (choice) {
                    case 1 -> registraPrenotazione();
                    case 2 -> cancellaPrenotazione();
                    case 3 -> System.exit(0);
                    default -> throw new ControllerException("Scelta non valida");
                }

            //gestione errori nello switch
            } catch (ControllerException e) {
                view.showError(e.getMessage());
            }
        }
    }


//DEFINIZIONE DI UNA FUNZIONE PER IL CONTROLLO DELL'ESECUZIONE DI OGNI OPERAZIONE SU CUI CLIENTE HA GRANT



    private void  registraPrenotazione() throws ControllerException {

        //invoca ClienteView per richiede i dati in input al Cliente
        RegistraPrenotazioneRequest request = view.richiediRegistraPrenotazione(cred);

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}

        try{
            //esecuzione procedura di registrazione prenotazione
            int idPrenotazione = new RegistraPrenotazioneProceduraDAO().execute(request);
            //invoca funzione di stampa a schermo dell'idPrenotazione
            view.visualizzaIdPrenotazione(idPrenotazione);

        } catch (DAOException e) {
            //gestione errori nella procedura di registrazione prenotazione
            throw new ControllerException(e.getMessage(), e);
        }
    }



    void  cancellaPrenotazione() throws ControllerException {

        //invoca ClienteView per richiede i dati in input al Cliente
        CancellaPrenotazioneRequest request = view.richiediCancellaPrenotazione(cred);

        //verifica che la richiesta sia andata a buon fine
        if (request == null) {return;}

        try{
            //esecuzione procedura di cancellazione prenotazione
            new CancellaPrenotazioneProceduraDAO().execute(request);
            //invoca funzione di stampa a schermo dell'esito positivo
            view.visualizzaEsitoCancellazione();

        } catch (DAOException e) {
            //gestione errori nella procedura di cancellazione prenotazione
            throw new ControllerException(e.getMessage(), e);
        }
    }
}