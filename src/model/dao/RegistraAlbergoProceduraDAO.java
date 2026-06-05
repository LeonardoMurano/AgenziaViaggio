package model.dao;

import exception.DAOException;
import model.dto.RegistraAlbergoRequest;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class RegistraAlbergoProceduraDAO {

    public void execute(RegistraAlbergoRequest input) throws DAOException {

        //estrazione del contenuto di RegistraAlbergoRequest
        String nomeAlbergo = input.nomeAlbergo();
        String referente = input.referente();
        BigDecimal costoNotteOspite = input.costoNotteOspite();
        int numeroMassimoOspiti = input.numeroMassimoOspiti();
        String indirizzo = input.indirizzo();
        String telefono = input.telefono();
        String fax = input.fax();
        String email = input.email();
        String citta = input.citta();

        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraAlbergo'
            CallableStatement cs = conn.prepareCall("{call registraAlbergo(?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, nomeAlbergo);
            cs.setString(2, referente);
            cs.setBigDecimal(3, costoNotteOspite);
            cs.setInt(4, numeroMassimoOspiti);
            cs.setString(5, indirizzo);
            cs.setString(6, telefono);
            cs.setString(7, fax);
            cs.setString(8, email);
            cs.setString(9, citta);
            cs.executeQuery();

            //non viene restituito alcun output
            //l'operazione va a buon fine se non sono restituiti errori

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione albergo: " + e.getMessage());
        }
    }
}
