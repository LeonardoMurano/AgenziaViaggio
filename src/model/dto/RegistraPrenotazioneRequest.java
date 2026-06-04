package model.dto;

import java.time.LocalDate;

public record RegistraPrenotazioneRequest(int numeroOspitiPrenotazione,
                                          String username,
                                          LocalDate dataPartenza,
                                          String itinerario){}