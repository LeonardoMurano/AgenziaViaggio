package model.dao;

import exception.DAOException;
import model.dto.AssociaAlbergoRequest;
import model.dto.RegistraItinerarioRequest;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class RegistraItinerarioProceduraDAO implements GenericaProceduraDAO<RegistraItinerarioRequest, Void>{

    public Void execute(RegistraItinerarioRequest input) throws DAOException {

        //estrazione del contenuto di RegistraItinerarioRequest
        String nomeItinerario = input.nomeItinerario();
        BigDecimal costo =  input.costo();
        List<Integer> numeroTappa = input.numeroTappa();
        List<Integer> durataTappa = input.durataTappa();
        List<String> citta = input.citta();

        //serializzazione attributi inerenti tappe notturne
        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < numeroTappa.size(); i++){
            sb.append(numeroTappa.get(i))
                    .append(":")
                    .append(durataTappa.get(i))
                    .append(":")
                    .append(citta.get(i));
            if (i < numeroTappa.size() - 1) {
                sb.append(";");
            }
        }
        //memorizzazione attributi inerenti le tappe notturne serializzati
        String tappe = sb.toString();

        try{
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'registraItinerario'
            CallableStatement cs = conn.prepareCall("{call registraItinerario(?,?,?)}");
            cs.setString(1, nomeItinerario);
            cs.setBigDecimal(2, costo);
            cs.setString(3, tappe);
            cs.executeQuery();

            //non viene restituito alcun output
            //l'operazione va a buon fine se non sono restituiti errori


        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella registrazione itinerario: " + e.getMessage());
        }

        return null;
    }
}
