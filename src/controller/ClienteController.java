/**Classe con responsabilità di controllo e coordinamento del flusso di esecuzione dell'applicazione
 * nel caso di utente autenticato con ruolo 'Cliente'
 */
package controller;

import exception.ApplicationException;
import exception.ControllerException;
import model.dao.ConnectionFactory;
import view.ClienteView;
import model.enums.Ruolo;

import java.sql.SQLException;

public class ClienteController implements Controller {

    //creazione istanza di ClienteView
    private final ClienteView view = new ClienteView();


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


//definire una funzione per ogni operazione di Cliente inserita nello switch
    void  registraPrenotazione() throws ControllerException {}
    void  cancellaPrenotazione() throws ControllerException {}
}
