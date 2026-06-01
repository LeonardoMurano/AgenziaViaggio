package exception;

public class DAOException extends ApplicationException {

    //classe con responsabilità di gestire le eccezioni custom inerenti le DAO
    //estende Exception: classe base di tutte le checked exceptions

    public DAOException() {
        super();
    }

    public DAOException(String message, Throwable cause) {
        super(message, cause);
    }

    public DAOException(String message) {
        super(message);
    }
}