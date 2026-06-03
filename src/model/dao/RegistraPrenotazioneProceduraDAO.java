package model.dao;

import exception.DAOException;
import model.dto.RegistraPrenotazioneRequest;

import java.sql.*;
import java.time.LocalDate;

public class RegistraPrenotazioneProceduraDAO {

    public int execute(RegistraPrenotazioneRequest input) throws DAOException {

        //estrazione del contenuto di LoginRequest
        int numeroOspitiprenotazione = input.numeroOspitiPrenotazione();
        String username = input.username();
        LocalDate dataPartenza = input.dataPartenza();
        String itinerario = input.itinerario();

        //dichiarazione attributo idPrenotazione
        int idPrenotazione;

        //esecuzione stored procedure 'registraItinerario'
        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraPrenotazione'
            CallableStatement cs = conn.prepareCall("{call registraPrenotazione(?,?,?,?,?,?,?)}");
            cs.setInt(1, numeroOspitiprenotazione);
            cs.setString(2, username);
            cs.setNull(3, Types.DATE);
            cs.setNull(4, Types.VARCHAR);
            cs.setDate(5, Date.valueOf(dataPartenza));
            cs.setString(6, itinerario);
            cs.registerOutParameter(7, Types.INTEGER);
            cs.executeQuery();

            //estrazione output della stored procedure 'registraPrenotazione'
            idPrenotazione = cs.getInt(7);


        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione Prenotazione: " + e.getMessage());
        }

        //restituisce al chiamante idPrenotazione
        return idPrenotazione;
    }
}
