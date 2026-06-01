/**CLASSE CON RESPONSABILITA' DI ESECUZIONE DELLA PROCEDURA DI LOGIN
 * > riceve in input il record LoginRequest
 * > restituisce in output l'oggetto Utente autenticato
 */
package model.dao;

import exception.DAOException;
import model.domain.Utente;
import model.dto.LoginRequest;
import model.enums.Ruolo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class LoginProcedureDAO implements GenericaProceduraDAO<LoginRequest, Utente> {

    @Override
    public Utente execute(LoginRequest input) throws DAOException {

        //estrazione del contenuto di LoginRequest
        String username = input.username();
        String password = input.password();

        //dichiarazione attributo ruolo
        int ruolo;

        //esecuzione stored procedure 'login'
        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            //preparazione ed esecuzione stored procedure 'login'
            CallableStatement cs = conn.prepareCall("{call login(?,?,?)}");
            cs.setString(1, username);
            cs.setString(2, password);
            //output==('CLIENTE')or('AGENTE'); tipo VARCHAR
            cs.registerOutParameter(3, Types.INTEGER);
            cs.executeQuery();

            //estrazione output della stored procedure 'login'
            ruolo = cs.getInt(3);

            //gestione eccezione dovuta a credenziali errate
        } catch (SQLException e) {
            throw new DAOException("Login error: " + e.getMessage());
        }

        //ritorna al chiamante l'Utente autenticato
        return new Utente(username, password, Ruolo.fromInt(ruolo));
    }
}
