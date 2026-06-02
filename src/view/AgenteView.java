/**classe con responsabilità di interfacciamento I/O
 * nel caso di utente autenticato con ruolo 'Agente'
 */
package view;

import java.util.Scanner;

public class AgenteView {

    //FUNZIONE CHE STAMPA IL MENU' E RACCOGLIE L'INPUT DELL'AGENTE
    public int showMenu() {

        //stampa in output del menù del Agente
        System.out.println("*********************************");
        System.out.println("*    DASHBOARD AGENTE    *");
        System.out.println("*********************************\n");
        System.out.println("*** Operazioni disponibili: ***\n");
        System.out.println("1) Registra itinerario");
        System.out.println("2) Registra edizione di viaggio futura");
        System.out.println("3) Registra albergo");
        System.out.println("4) Registra autobus dell'agenzia");
        System.out.println("5) Associa autobus dell'agenzia");
        System.out.println("6) Associa albergo");
        System.out.println("7) Genera report edizione di viaggio passata");
        System.out.println("8) Esci dal sistema");

        //dichiarazione lettore da tastiera (legge input da console)
        Scanner input = new Scanner(System.in);
        //dichiarazione variabile in cui memorizzare la scelta dell'Agente
        int choice;

        //inizializzazione ciclo infinito
        //prosegue fino a quando l'Agente non inserisce choice valido
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

        //restituzione al chiamante della scelta effettuata da Agente
        return choice;
    }

    //FUNZIONE CHE STAMPA MESSAGGI DI ERRORE ALL'AGENTE
    public void showError(String message) {
        System.out.println("Error: " + message);
    }



    //definire una funzione per ogni operazione su cui Agente ha grant
}
