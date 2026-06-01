//classe con responsabilità di coordinamento del processo di autenticazione utente

package controller;

import java.io.IOException;

import exception.DAOException;
import model.dao.LoginProceduraDAO;
import model.dao.LoginProceduraDAO;
import model.domain.Utente;
import view.LoginView;
import model.dto.LoginRequest;


public class LoginController implements Controller {


    //inizializzazione del riferimento ad Utente al valore null
    Utente cred = null;

    //FUNZIONE DI AVVIO DEL LoginController
    @Override
    public void start() {

        //richiesta in input delle credenziali dell'utente
        try {
            cred = LoginView.authenticate();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }

        //costruzione del record di LoginRequest
        LoginRequest loginRequest = new LoginRequest(cred.getCodiceFiscale(), cred.getPassword());

        //esecuzione procedura di login
        try {
            cred = new LoginProceduraDAO().execute(loginRequest);
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }


    //METODO DI RICHIESTA CREDENZIALI
    //restituisce le credenziali dell'utente
    public Utente getCred() {
        return cred;
    }
}