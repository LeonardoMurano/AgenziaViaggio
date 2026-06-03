/**classe con responsabilità di interfacciamento I/O
 * nel caso di utente autenticato con ruolo 'Cliente'
 */
package view;

import model.domain.Utente;
import model.dto.RegistraItinerarioRequest;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Scanner;

public class ClienteView {

    //FUNZIONE CHE STAMPA IL MENU' E RACCOGLIE L'INPUT DEL CLIENTE
    public int showMenu() {

        //stampa in output del menù del Cliente
        System.out.println("*********************************");
        System.out.println("*    DASHBOARD CLIENTE    *");
        System.out.println("*********************************\n");
        System.out.println("*** Operazioni disponibili: ***\n");
        System.out.println("1) Registra prenotazione");
        System.out.println("2) Cancella prenotazione");
        System.out.println("4) Esci dal sistema");

        //dichiarazione lettore da tastiera (legge input da console)
        Scanner input = new Scanner(System.in);
        //dichiarazione variabile in cui memorizzare la scelta del Cliente
        int choice;

        //inizializzazione ciclo infinito
        //prosegue fino a quando il Cliente non inserisce choice valido
        while (true) {
            //stampa in output del messaggio di richiesta input da console
            System.out.print("Selezionare l'operazione da eseguire: ");
            try {
                //conversione String->int dell'input ricevuto e memorizzazione in choice
                choice = Integer.parseInt(input.nextLine());

                //verifica se l'input ricevuto è valido
                if (choice >= 1 && choice <= 4) {
                    //se valido, esce dal ciclo while(True)
                    break;
                }

            //gestione errori di formato dell'input
            } catch (NumberFormatException e) {
                //se l'input ricevuto non è del formato atteso, ignora l'eccezione e reitera while(True)
            }

            //stampa in output del messaggio di errore
            System.out.println("Opzione non valida");
        }

        //restituzione al chiamante della scelta effettuata da Cliente
        return choice;
    }

    //FUNZIONE CHE STAMPA MESSAGGI DI ERRORE AL CLIENTE
    public void showError(String message) {
        System.out.println("Error: " + message);
    }



    //definire una funzione per ogni operazione su cui Cliente ha grant

    public RegistraItinerarioRequest richiediRegistraPrenotazione(Utente cred){

        //richiesta in input delle informazioni inerenti la prenotazione da registrare
        Scanner input = new Scanner(System.in);
        System.out.print("OPERAZIONE DI REGISTRAZIONE PRENOTAZIONE");
        System.out.print("Itinerario: ");
        String itinerario = input.nextLine();
        System.out.print("Data di partenza (yyyy-MM-dd): ");
        String stringDataPartenza = input.nextLine();
        System.out.print("Numero di ospiti per cui si effettua la prenotazione: ");
        String stringNumeroOspitiPrenotazione = input.nextLine();

        //estrazione dello username del Cliente da cred
        String username = cred.getUsername();

        try{
            //conversione formato String->LocalDate
            LocalDate dataPartenza = LocalDate.parse(stringDataPartenza);
            //conversione formato String->int
            int numeroOspitiPrenotazione = Integer.parseInt(stringNumeroOspitiPrenotazione);

            //restituzione riferimento alla nuova istanza di record di RegistraItinerarioRequest
            return new RegistraItinerarioRequest(numeroOspitiPrenotazione,username, dataPartenza, itinerario);

        } catch (DateTimeParseException e) {
            //gestione errore dovuto a formato della data di partenza non valido
            System.out.println("Formato della data non valido. Utilizzare yyyy-MM-dd.\n");
            return null;
        } catch (NumberFormatException e) {
            //gestione errore dovuto a formato del numero di ospiti non valido
            System.out.println("Formato del numero di ospiti non valido. Utilizzare un valore numerico intero.\n");
            return null;
        }
    }

}
