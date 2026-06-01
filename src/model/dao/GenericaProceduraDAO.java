/**INTERFACCIA GENERICA PER PROCEDURE DAO:
 *
 * > riceve un input I di tipo generico
 * > restituisce un output O di tipo generico
 * ------
 * i tipi di I,O sono definiti nelle classi che realizzano l'interfaccia
 */

package model.dao;

import exception.DAOException;

import java.sql.SQLException;

public interface GenericaProceduraDAO<I, O> {

    //dichiarazione operazione che esegue una procedura usando un input I e restituendo un output O
    O execute(I input) throws DAOException, SQLException;

}
