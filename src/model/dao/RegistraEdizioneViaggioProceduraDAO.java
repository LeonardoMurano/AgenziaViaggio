package model.dao;

import exception.DAOException;
import model.dto.RegistraEdizioneViaggioRequest;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

public class RegistraEdizioneViaggioProceduraDAO {

    public void execute(RegistraEdizioneViaggioRequest input) throws DAOException {

        //estrazione del contenuto di RegistraEdizioneViaggioRequest
        String nomeItinerario = input.nomeItinerario();
        LocalDate dataPartenza = input.dataPartenza();
        BigDecimal costoOperativo = input.costoOperativo();

        try{
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraEdizioneViaggio'
            CallableStatement cs = conn.prepareCall("{call registraEdizioneViaggio(?,?,?)}");
            cs.setString(1, nomeItinerario);
            cs.setDate(2, Date.valueOf(dataPartenza));
            cs.setBigDecimal(3, costoOperativo);
            cs.executeQuery();

            //non viene restituito alcun output
            //l'operazione va a buon fine se non sono restituiti errori

        }catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione edizione di viaggio: " + e.getMessage());
        }
    }
}
