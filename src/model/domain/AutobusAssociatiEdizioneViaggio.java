package model.domain;

public class AutobusAssociatiEdizioneViaggio {

    int capienzaTotale;
    int capienzaRichiesta;
    int capienzaResidua;
    boolean necessitaAltriAutobus;


    //definizione costruttore di AutobusAssociatiEdizioneViaggio
    public AutobusAssociatiEdizioneViaggio(int capienzaTotale, int capienzaRichiesta) {

        this.capienzaTotale = capienzaTotale;
        this.capienzaRichiesta = capienzaRichiesta;
        //invocazione funzione di calcolo attributi derivati
        calcolaDerivati();
    }


    //definizione metodo di calcolo attributi derivati
    private void calcolaDerivati() {
        this.capienzaResidua = capienzaTotale - capienzaTotale;
        this.necessitaAltriAutobus = capienzaResidua > 0;
    }


    //definizione metodo di costruzione dell'esito dell'associazione
    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        if (necessitaAltriAutobus) {
            sb.append("ATTENZIONE: è necessario associare ulteriori autobus dell'agenzia.\n");
        } else {
            sb.append("Non è necessario associare ulteriori autobus dell'agenzia.\n");
        }

        sb.append("Capienza totale autobus associati: ")
                .append(capienzaTotale).append("\n");

        sb.append("Capienza totale richiesta autobus associati: ")
                .append(capienzaRichiesta).append("\n");

        if (necessitaAltriAutobus) {
            sb.append("Capienza richiesta residua: ")
                    .append(capienzaResidua).append("\n");
        }

        return sb.toString();
    }
}
