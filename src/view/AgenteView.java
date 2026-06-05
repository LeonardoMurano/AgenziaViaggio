/**classe con responsabilità di interfacciamento I/O
 * nel caso di utente autenticato con ruolo 'Agente'
 */
package view;

import model.dto.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
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
                if (choice >= 1 && choice <= 8) {
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



    //FUNZIONI VIEW RELATIVE OPERAZIONE: AG1 - RegistraItinerario

    public RegistraItinerarioRequest  registraItinerarioRichiedi() {

        //richiesta in input delle informazioni inerenti l'itinerario da registrare
        Scanner input = new Scanner(System.in);
        System.out.print("\n*** OPERAZIONE DI REGISTRAZIONE ITINERARIO ***\n");
        System.out.print("Nome itinerario: ");
        String nomeItinerario = input.nextLine();
        System.out.print("Costo itinerario: ");
        String StringCosto = input.nextLine();
        System.out.print("Numero tappe: ");
        String stringCounterTappe = input.nextLine();

        try{
            //conversione formato String->BigDecimal
            BigDecimal costo = new BigDecimal(StringCosto);
            //conversione formato String->int
            int counterTappe = Integer.parseInt(stringCounterTappe);

            //verifica validità argomento numeroTappe
            if (counterTappe < 1) {
                //gestione errore dovuto ad argomento numeroTappe non valido
                System.out.println("\nArgomento del numero di tappe non valido. Inserire un valore >=1.\n");
                return null;
            }

            //inizializzazione liste in cui memorizzare informazioni inerenti le tappe
            List<Integer> durataTappa = new ArrayList<>();
            List<Integer> numeroTappa = new ArrayList<>();
            List<String> citta = new ArrayList<>();

            //richiesta in input delle informazioni inerenti ogni tappa
            for (int i = 0; i < counterTappe; i++) {
                System.out.print("Durata tappa " + (i+1) + "-esima: ");
                String stringDurataTappa = input.nextLine();
                System.out.print("Città tappa " + (i+1) + "-esima: ");
                citta.add(input.nextLine());
                durataTappa.add(Integer.parseInt(stringDurataTappa));
                numeroTappa.add(i);
            }

            //verifica coerenza liste parallele
            int size = numeroTappa.size();
            if (durataTappa.size() != size || citta.size() != size) {
                //gestione errore dovuto a liste incoerenti
                throw new IllegalStateException("Liste tappe incoerenti");
            }

            //restituzione riferimento alla nuova istanza di record di RegistraItinerarioRequest
            return new RegistraItinerarioRequest(nomeItinerario, costo, numeroTappa, durataTappa, citta);

        } catch (NumberFormatException e) {
            //gestione errore dovuto a formato numeroTappe, costo o durataTappa[i] non valido
            System.out.println("\nFormato non valido. Utilizzare un valore numerico intero.\n");
            return null;
        }
    }

    public void visualizzaEsitoRegistrazioneItinerario(){

        //stampa a schermo l'esito positivo dell'operazione registraItinerario
        System.out.println("*********************************");
        System.out.println("Registrazione itinerario completata con successo.\n");
    }


    //FUNZIONI VIEW RELATIVE OPERAZIONE: AG2 - RegistraEdizioneViaggio

    public RegistraEdizioneViaggioRequest registraEdizioneViaggioRichiedi(){

        //richiesta in input delle informazioni inerenti l'edizione di viaggio da registrare
        Scanner input = new Scanner(System.in);
        System.out.print("\n*** OPERAZIONE DI REGISTRAZIONE EDIZIONE VIAGGIO ***\n");
        System.out.print("Nome itinerario: ");
        String nomeItinerario = input.nextLine();
        System.out.print("Data di partenza: ");
        String StringDataPartenza = input.nextLine();
        System.out.print("Costo operativo: ");
        String StringCostoOperativo = input.nextLine();

        try{
            //conversione formato String->LocalDate
            LocalDate dataPartenza = LocalDate.parse(StringDataPartenza);
            //conversione formato String->BigDecimal
            BigDecimal costoOperativo = new BigDecimal(StringCostoOperativo);

            //restituzione riferimento alla nuova istanza di record di RegistraEdizioneViaggioRequest
            return new RegistraEdizioneViaggioRequest(nomeItinerario, dataPartenza, costoOperativo);

        } catch (DateTimeParseException e) {
            //gestione errore dovuto a formato delle date non valido
            System.out.println("\nFormato della data non valido. Utilizzare yyyy-MM-dd.\n");
            return null;
        } catch (NumberFormatException e) {
            //gestione errore dovuto a formato del costoOperativo non valido
            System.out.println("\nFormato del costo Operativo non valido. Utilizzare un valore numerico decimale.\n");
            return null;
        }
    }


    public void visualizzaEsitoRegistrazioneEdizioneViaggio() {

        //stampa a schermo l'esito positivo dell'operazione registraEdizioneViaggio
        System.out.println("*********************************");
        System.out.println("Registrazione edizione di viaggio completata con successo.\n");
    }


    //FUNZIONI VIEW RELATIVE OPERAZIONE: AG3 - RegistraAlbergo

    public RegistraAlbergoRequest registraAlbergoRichiedi() {

        //richiesta in input delle informazioni inerenti l'albergo da registrare
        Scanner input = new Scanner(System.in);
        System.out.print("\n*** OPERAZIONE DI REGISTRAZIONE ALBERGO ***\n");
        System.out.print("Nome albergo: ");
        String nomeAlbergo = input.nextLine();
        System.out.print("Referente: ");
        String referente = input.nextLine();
        System.out.print("Costo per notte ad ospite: ");
        String stringCostoNotteOspite = input.nextLine();
        System.out.print("Numero massimo ospiti: ");
        String stringNumeroMassimoOspiti = input.nextLine();
        System.out.print("Indirizzo: ");
        String indirizzo = input.nextLine();
        System.out.print("Telefono: ");
        String telefono = input.nextLine();
        System.out.print("Fax: ");
        String fax = input.nextLine();
        System.out.print("Email: ");
        String email = input.nextLine();
        System.out.print("Città: ");
        String citta = input.nextLine();

        try{
            //conversione formato String->BigDecimal
            BigDecimal costoNotteOspite = new BigDecimal(stringCostoNotteOspite);
            //conversione formato String->int
            int numeroMassimoOspiti = Integer.parseInt(stringNumeroMassimoOspiti);

            //restituzione riferimento alla nuova istanza di record di RegistraAlbergoRequest
            return new RegistraAlbergoRequest(nomeAlbergo, referente, costoNotteOspite,
                                              numeroMassimoOspiti, indirizzo, telefono,
                                              fax, email, citta);

        } catch (NumberFormatException e) {
            //gestione errore dovuto a formati numerici non validi
            System.out.println("\nFormato numerico non valido. Utilizzare un valore valido.\n");
            return null;
        }
    }


    public void visualizzaEsitoRegistrazioneAlbergo() {

        //stampa a schermo l'esito positivo dell'operazione registraEdizioneViaggio
        System.out.println("*********************************");
        System.out.println("Registrazione albergo completata con successo.\n");
    }


    //FUNZIONI VIEW RELATIVE OPERAZIONE: AG4 - RegistraAutobusAgenzia

    public RegistraAutobusAgenziaRequest registraAutobusAgenziaRichiedi() {

        //richiesta in input delle informazioni inerenti l'autobus da registrare
        Scanner input = new Scanner(System.in);
        System.out.print("\n*** OPERAZIONE DI REGISTRAZIONE AUTOBUS DELL'AGENZIA ***\n");
        System.out.print("Costo: ");
        String stringCostoMezzo = input.nextLine();
        System.out.print("Capienza: ");
        String stringCapienza = input.nextLine();

        try{
            //conversione formato String->BigDecimal
            BigDecimal costoMezzo = new BigDecimal(stringCostoMezzo);
            //conversione formato String->int
            int capienza = Integer.parseInt(stringCapienza);

            //restituzione riferimento alla nuova istanza di record di RegistraAutobusAgenziaRequest
            return new RegistraAutobusAgenziaRequest(costoMezzo, capienza);

        } catch (NumberFormatException e) {
            //gestione errore dovuto a formati numerici non validi
            System.out.println("\nFormato numerico non valido. Utilizzare un valore valido.\n");
            return null;
        }
    }


    public void visualizzaIdMezzo(int idMezzo) {

        //stampa a schermo l'esito positivo dell'operazione registraAutobusAgenzia
        System.out.println("*********************************");
        System.out.println("Registrazione autobus dell'agenzia completata con successo.");
        System.out.println("ID mezzo: " + idMezzo + "\n");
    }


    //FUNZIONI VIEW RELATIVE OPERAZIONE: AG5 - AssociaAutobusAgenzia

    public AssociaAutobusAgenziaRequest associaAutobusAgenziaRichiedi() {

        //richiesta in input delle informazioni inerenti l'autobus da associare
        Scanner input = new Scanner(System.in);
        System.out.print("\n*** OPERAZIONE DI ASSOCIAZIONE AUTOBUS AGENZIA - EDIZIONE VIAGGIO ***\n");
        System.out.print("ID mezzo da associare: ");
        String stringIdMezzo = input.nextLine();
        System.out.print("Itinerario dell'edizione: ");
        String itinerario = input.nextLine();
        System.out.print("Data di partenza: ");
        String stringDataPartenza = input.nextLine();

        try{
            //conversione formato String->int
            int idMezzo = Integer.parseInt(stringIdMezzo);
            //conversione formato String->LocalDate
            LocalDate dataPartenza = LocalDate.parse(stringDataPartenza);

            //restituzione riferimento alla nuova istanza di record di AssociaAutobusAgenziaRequest
            return new AssociaAutobusAgenziaRequest(idMezzo, itinerario, dataPartenza);

        } catch (NumberFormatException e) {
            //gestione errore dovuto a formati numerici non validi
            System.out.println("\nFormato numerico non valido. Utilizzare un valore valido.\n");
            return null;
        } catch (DateTimeParseException e) {
            //gestione errore dovuto a formato delle date non valido
            System.out.println("\nFormato della data non valido. Utilizzare yyyy-MM-dd.\n");
            return null;
        }
    }


    public void visualizzaEsitoAssociazioneAlbergo(AssociaAutobusAgenziaOutput output) {

        //estrazione del contenuto di AssociaAutobusAgenziaOutput
        int capienzaTotale = output.capienzaTotale();
        int capienzaRichiesta = output.numeroOspitiTotale();

        //stampa a schermo l'esito positivo dell'operazione registraAutobusAgenzia
        System.out.println("*********************************");
        System.out.println("Associazione autobus dell'agenzia completata con successo.");

        //calcolo numero ospiti mancanti
        int capienzaResidua = capienzaRichiesta - capienzaTotale;

        if (capienzaResidua > 0) {
            System.out.println("ATTENZIONE: è necessario associare ulteriori autobus dell'agenzia.");
            System.out.println("Capienza totale autobus associati: " + capienzaTotale);
            System.out.println("Capienza totale richiesta autobus associati: " + capienzaRichiesta);
            System.out.println("Capienza richiesta residua: " + capienzaResidua + "\n");
        } else {
            System.out.println("Non è necessario associare ulteriori autobus dell'agenzia.");
            System.out.println("Capienza totale autobus associati: " + capienzaTotale);
            System.out.println("Capienza totale richiesta autobus associati: " + capienzaRichiesta + "\n");
        }
    }
}