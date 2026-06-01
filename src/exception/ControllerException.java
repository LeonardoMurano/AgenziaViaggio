package exception;

public class ControllerException extends ApplicationException {

    //classe con responsabilità di gestire le eccezioni custom inerenti i controller
    //estende Exception: classe base di tutte le checked exceptions

    public ControllerException() {
        super();
    }

    public ControllerException(String message, Throwable cause) {
        super(message, cause);
    }

    public ControllerException(String message) {
        super(message);
    }
}
