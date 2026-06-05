package model.dao;

import exception.DAOException;
import model.dto.RegistraPrenotazioneRequest;

import java.sql.*;
import java.time.LocalDate;

public class RegistraPrenotazioneProceduraDAO {

    public int execute(RegistraPrenotazioneRequest input) throws DAOException {

        //estrazione del contenuto di RegistraPrenotazioneRequest
        int numeroOspitiprenotazione = input.numeroOspitiPrenotazione();
        String username = input.username();
        LocalDate dataPartenza = input.dataPartenza();
        String itinerario = input.itinerario();

        //dichiarazione attributo idPrenotazione
        int idPrenotazione;

        //esecuzione stored procedure 'registraPrenotazione'
        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraPrenotazione'
            CallableStatement cs = conn.prepareCall("{call registraPrenotazione(?,?,?,?,?)}");
            cs.setInt(1, numeroOspitiprenotazione);
            cs.setString(2, username);;
            cs.setDate(3, Date.valueOf(dataPartenza));
            cs.setString(4, itinerario);
            cs.registerOutParameter(5, Types.INTEGER);
            cs.executeQuery();

            //estrazione output della stored procedure 'registraPrenotazione'
            idPrenotazione = cs.getInt(5);

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione prenotazione: " + e.getMessage());
        }

        //restituisce al chiamante idPrenotazione
        return idPrenotazione;
    }
}
