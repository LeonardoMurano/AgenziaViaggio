//classe con responsabilità di coordinamento delle operazioni di avvio dell'applicazione

package controller;

import exception.ApplicationException;
import model.domain.Utente;

public class ApplicationController implements Controller {


    //attributo in cui viene memorizzato il riferimento all'oggetto Utente
    //necessario per accedere alle credenziali di login
    Utente cred;


    //FUNZIONE DI AVVIO DELL'ApplicationController
    @Override
    public void start() throws ApplicationException {

        //creazione di un nuovo oggetto di loginController
        LoginController loginController = new LoginController();

        //avvio del loginController
        loginController.start();

        //ricezione credenziali
        cred = loginController.getCred();

        //verifica validità credenziali
        if(cred.getRuolo() == null) {
            throw new RuntimeException("Invalid credentials");
        }


        //switch sulla base del ruolo dell'utente autenticato
        switch(cred.getRuolo()) {

            //crea e avvia l'opportuno controller, in base al ruolo dell'utente

            case CLIENTE -> new AgenziaController().start();
            case AGENTE -> new AmministratoreController().start();
            default -> throw new RuntimeException("Invalid credentials");
        }
    }
}
