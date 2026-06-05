package model.dao;

import exception.DAOException;
import model.dto.AssociaAutobusAgenziaOutput;
import model.dto.AssociaAutobusAgenziaRequest;

import java.sql.*;
import java.time.LocalDate;

public class AssociaAutobusAgenziaProceduraDAO {

    public AssociaAutobusAgenziaOutput execute(AssociaAutobusAgenziaRequest input) throws DAOException {

        //estrazione del contenuto di AssociaAutobusAgenziaRequest
        int idMezzo = input.idMezzo();
        String itinerario = input.itinerario();
        LocalDate dataPartenza = input.dataPartenza();

        //dichiarazione attributi in cui memorizzare output
        int capienzaTotale;
        int numeroOspitiTotale;

        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'associaAutobusAgenzia'
            CallableStatement cs = conn.prepareCall("{call associaAutobusAgenzia(?,?,?,?,?)}");
            cs.setInt(1, idMezzo);
            cs.setString(2, itinerario);
            cs.setDate(3, Date.valueOf(dataPartenza));
            cs.registerOutParameter(4, Types.INTEGER);
            cs.registerOutParameter(5, Types.INTEGER);
            cs.executeQuery();

            //estrazione output della stored procedure 'associaAutobusAgenzia'
            capienzaTotale = cs.getInt(4);
            numeroOspitiTotale = cs.getInt(5);

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nell'associazione dell'autobus: " + e.getMessage());
        }

        //restituisce al chiamante l'output della stored procedure
        return new AssociaAutobusAgenziaOutput(capienzaTotale, numeroOspitiTotale);
    }
}
