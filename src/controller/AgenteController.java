/**Classe con responsabilità di controllo e coordinamento del flusso di esecuzione dell'applicazione
 * nel caso di utente autenticato con ruolo 'Agente'
 */
package controller;

import exception.ApplicationException;
import exception.ControllerException;
import model.dao.ConnectionFactory;
import view.AgenteView;
import model.enums.Ruolo;

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


    //definire una funzione per ogni operazione di Agente inserita nello switch
    void  RegistraItinerario() throws ControllerException {}
    void  RegistraEdizioneViaggio() throws ControllerException {}
    void  RegistraAlbergo() throws ControllerException {}
    void  RegistraAutobusAgenzia() throws ControllerException {}
    void  AssociaAutobusAgenzia() throws ControllerException {}
    void  AssociaAlbergo() throws ControllerException {}
    void  ReportEdizioneViaggio() throws ControllerException {}
}

