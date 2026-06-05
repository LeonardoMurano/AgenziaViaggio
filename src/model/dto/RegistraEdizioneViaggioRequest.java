package model.dto;

public record RegistraEdizioneViaggioRequest(String nomeItinerario,
                                             java.time.LocalDate dataPartenza,
                                             java.math.BigDecimal costoOperativo) {
}
