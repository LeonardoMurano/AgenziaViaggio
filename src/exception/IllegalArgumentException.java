package exception;

public class IllegalArgumentException extends Exception{

    //classe con responsabilità di gestire le eccezioni custom inerenti l'inserimento in input di valori non ammessi
    //estende Exception: classe base di tutte le checked exceptions

    public IllegalArgumentException() {super();}

    public IllegalArgumentException(String message, Throwable cause) {super(message, cause);}

    public IllegalArgumentException(String message) {super(message);}
}
