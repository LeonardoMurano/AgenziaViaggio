package model.dto;

import java.math.BigDecimal;
import java.util.List;

public record RegistraItinerarioRequest(String nomeItinerario,
                                        BigDecimal costo,
                                        List<Integer> numeroTappa,
                                        List<Integer> durataTappa,
                                        List<String> citta) {
}
