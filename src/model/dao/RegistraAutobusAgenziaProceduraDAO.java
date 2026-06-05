package model.dao;

import exception.DAOException;
import model.dto.RegistraAutobusAgenziaRequest;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class RegistraAutobusAgenziaProceduraDAO {

    public int execute(RegistraAutobusAgenziaRequest input) throws DAOException{

        //estrazione del contenuto di RegistraAutobusAgenziaRequest
        BigDecimal costoMezzo = input.costoMezzo();
        int capienza = input.capienza();

        //dichiarazione attributo idMezzo
        int idMezzo;

        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraAutobusAgenzia'
            CallableStatement cs = conn.prepareCall("{call registraAutobusAgenzia(?,?,?)}");
            cs.setBigDecimal(1, costoMezzo);
            cs.setInt(2, capienza);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.executeQuery();

            //estrazione output della stored procedure 'registraAutobusAgenzia'
            idMezzo = cs.getInt(3);

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione autobus dell'agenzia: " + e.getMessage());
        }

        //restituisce al chiamante idPrenotazione
        return idMezzo;
    }
}
