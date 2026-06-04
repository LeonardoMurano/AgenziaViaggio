package model.dao;

import exception.DAOException;
import model.dto.CancellaPrenotazioneRequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class CancellaPrenotazioneProceduraDAO {

    public void execute(CancellaPrenotazioneRequest input) throws DAOException {

        //estrazione del contenuto di CancellaPrenotazioneRequest
        int idPrenotazione = input.idPrenotazione();
        String username = input.username();

        //esecuzione stored procedure 'cancellaPrenotazione'
        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'cancellaPrenotazione'
            CallableStatement cs = conn.prepareCall("{call cancellaPrenotazione(?,?)}");
            cs.setInt(1, idPrenotazione);
            cs.setString(2, username);
            cs.executeQuery();

            //non viene restituito alcun output
            //l'operazione va a buon fine se non sono restituiti errori

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella cancellazione prenotazione: " + e.getMessage());
        }
    }
}
