package model.dao;

import exception.DAOException;
import model.dto.RegistraItinerarioRequest;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class RegistraItinerarioProceduraDAO {

    public void execute(RegistraItinerarioRequest input) throws DAOException {

        //estrazione del contenuto di RegistraItinerarioRequest
        String nomeItinerario = input.nomeItinerario();
        BigDecimal costo =  input.costo();
        List<Integer> numeroTappa = input.numeroTappa();
        List<Integer> durataTappa = input.durataTappa();
        List<String> citta = input.citta();

        try{
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();

            //preparazione statement per il popolamento della tabella di sostegno 'TappeTemp'
            PreparedStatement ps = conn.prepareStatement("INSERT INTO TappeTemp (numeroTappa, durata, itinerario, citta) VALUES (?,?,?,?)");

            //popolamento della tabella di sostegno 'TappeTemp'
            for(int i = 0; i < numeroTappa.size(); i++){
                ps.setInt(1, numeroTappa.get(i));
                ps.setInt(2, durataTappa.get(i));
                ps.setString(3, nomeItinerario);
                ps.setString(4, citta.get(i));
                ps.executeUpdate();
            }

            //preparazione ed esecuzione stored procedure 'registraItinerario'
            CallableStatement cs = conn.prepareCall("{call registraItinerario(?,?)}");
            cs.setString(1, nomeItinerario);
            cs.setBigDecimal(2, costo);
            cs.executeQuery();

            //non viene restituito alcun output
            //l'operazione va a buon fine se non sono restituiti errori


        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione itinerario: " + e.getMessage());
        }
    }
}
