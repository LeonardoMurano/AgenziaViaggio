package model.dto;

import java.time.LocalDate;

public record AssociaAlbergoRequest(String itinerario,
                                    LocalDate dataPartenza,
                                    int numeroTappa,
                                    String citta,
                                    String nomeAlbergo) {
}
