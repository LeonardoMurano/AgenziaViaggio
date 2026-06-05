package model.dto;

import java.time.LocalDate;

public record AssociaAutobusAgenziaRequest(int  idMezzo, String itinerario, LocalDate dataPartenza) {
}
