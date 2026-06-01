package model.enums;

public enum Ruolo {
    CLIENTE(1),
    AGENTE(2);


    //dichiarazione identificatore numerico dei ruoli
    private final int id;


    //COSTRUTTORE PRIVATO DI 'Ruolo'
    //viene invocato dalla JVM al caricamento in memoria per creare una istanza di ogni valore definito
    private Ruolo(int id) {
        this.id = id;
    }

    //METODO PER LA CONVERSIONE id-->enum
    //associa all'id ricevuto in input il valore di Ruolo ad esso associato
    public static Ruolo fromInt(int id) {

        //values() restituisce tutti i valori dell'enum
        //ciclo for-each type
        for (Ruolo type : values()) {
            if (type.getId() == id) {
                return type;
            }
        }
        //for-each type:values() if (type.getId() != id) then
        return null;
    }

    //METODO PER LA CONVERSIONE enum-->id
    //associa al valore dell'enum su cui viene invocato l'id ad esso associato
    public int getId() {return id;}
}
