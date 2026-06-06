package model.dao;

import exception.DAOException;
import model.dto.AssociaAlbergoRequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

public class AssociaAlbergoProceduraDAO {

    public void execute(AssociaAlbergoRequest input) throws DAOException {

        //estrazione del contenuto di AssociaAlbergoRequest
        String itinerario = input.itinerario();
        LocalDate dataPartenza = input.dataPartenza();
        int numeroTappa = input.numeroTappa();
        String citta = input.citta();
        String nomeAlbergo = input.nomeAlbergo();

        try{
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'associaAlbergo'
            CallableStatement cs = conn.prepareCall("{call associaAlbergo(?,?,?,?,?)}");
            cs.setString(1, itinerario);
            cs.setDate(2, Date.valueOf(dataPartenza));
            cs.setInt(3, numeroTappa);
            cs.setString(4, citta);
            cs.setString(5, nomeAlbergo);
            cs.executeQuery();


        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nell'associazione dell'albergo: " + e.getMessage());
        }
    }
}
