package model.dto;

import java.math.BigDecimal;

public record RegistraAutobusAgenziaRequest(BigDecimal costoMezzo, int capienza) {
}
