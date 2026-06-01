package exception;

public class ApplicationException extends Exception {

    //classe con responsabilità di gestire le eccezioni custom inerenti l'applicazione
    //estende Exception: classe base di tutte le checked exceptions

    public ApplicationException() {super();}

    public ApplicationException(String message, Throwable cause) {super(message, cause);}

    public ApplicationException(String message) {super(message);}
}