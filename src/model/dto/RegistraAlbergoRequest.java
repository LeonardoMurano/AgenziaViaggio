package model.dto;

import java.math.BigDecimal;

public record RegistraAlbergoRequest(String nomeAlbergo,
                                     String referente,
                                     BigDecimal costoNotteOspite,
                                     int numeroMassimoOspiti,
                                     String indirizzo,
                                     String telefono,
                                     String fax,
                                     String email,
                                     String citta) {
}
