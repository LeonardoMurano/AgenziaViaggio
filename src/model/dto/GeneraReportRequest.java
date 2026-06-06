package model.dto;

import java.time.LocalDate;

public record GeneraReportRequest(String itinerario, LocalDate dataPartenza) {
}
