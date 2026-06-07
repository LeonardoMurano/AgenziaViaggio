package model.dao;

import exception.DAOException;
import model.domain.AlbergoReport;
import model.domain.Report;
import model.domain.UtenteReport;
import model.domain.AutobusReport;
import model.dto.AssociaAlbergoRequest;
import model.dto.GeneraReportRequest;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CostruisciReportProceduraDAO implements GenericaProceduraDAO<GeneraReportRequest, Report>{

    public Report execute(GeneraReportRequest input) throws DAOException {

        //estrazione del contenuto di GeneraReportRequest
        String itinerario = input.itinerario();
        LocalDate dataPartenza = input.dataPartenza();

        //inizializzazione variabili locali
        LocalDate dataRientro = null;
        int numeroOspitiTotale = 0;
        BigDecimal costoOperativo = BigDecimal.ZERO;
        BigDecimal costoItinerario = BigDecimal.ZERO;
        //creazione liste di sostegno
        List<UtenteReport> utenteReport = new ArrayList<>();
        List<AlbergoReport> albergoReport = new ArrayList<>();
        List<AutobusReport> autobusReport = new ArrayList<>();

        try {
            //preparazione connessione
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call generaReport(?,?)}");
            cs.setString(1, itinerario);
            cs.setDate(2, Date.valueOf(dataPartenza));
            cs.execute();

            //estrazione output del primo resultSet
            ResultSet rs1 = cs.getResultSet();

            //estrazione riga per riga del primo ResultSet
            while (rs1.next()) {
                String username = rs1.getString(1);
                String nomeUtente = rs1.getString(2);
                String cognomeUtente = rs1.getString(3);
                int idPrenotazione = rs1.getInt(4);
                int numeroOspitePrenotazione = rs1.getInt(5);

                //aggiunta nuova riga in UtenteReport
                utenteReport.add(new UtenteReport(username,
                        nomeUtente,
                        cognomeUtente,
                        idPrenotazione,
                        numeroOspitePrenotazione));
            }


            //richiesta del successivo resultSet
            cs.getMoreResults();

            //estrazione contenuto del secondo resultSet
            ResultSet rs2 = cs.getResultSet();

            //estrazione riga per riga del secondo ResultSet
            while (rs2.next()) {
                String nomeAlbergo = rs2.getString(1);
                BigDecimal costoNotteOspite = rs2.getBigDecimal(2);
                int durataTappa = rs2.getInt(3);

                //aggiunta nuova riga in AlbergoReport
                albergoReport.add(new AlbergoReport(nomeAlbergo,
                        costoNotteOspite,
                        durataTappa));
            }

            //richiesta del successivo resultSet
            cs.getMoreResults();

            //estrazione contenuto del terzo resultSet
            ResultSet rs3 = cs.getResultSet();

            //estrazione riga per riga del terzo ResultSet
            while (rs3.next()) {
                int idMezzo = rs3.getInt(1);
                BigDecimal costoMezzo = rs3.getBigDecimal(2);

                //aggiunta nuova riga in autobusReport
                autobusReport.add(new AutobusReport(idMezzo,
                        costoMezzo));
            }

            //richiesta del successivo resultSet
            cs.getMoreResults();

            //estrazione contenuto del quarto resultSet
            ResultSet rs4 = cs.getResultSet();

            if (rs4.next()) {
                dataRientro = rs4.getDate(1).toLocalDate();
                numeroOspitiTotale = rs4.getInt(2);
                costoOperativo = rs4.getBigDecimal(3);
                costoItinerario = rs4.getBigDecimal(4);
            }

        } catch (SQLException e) {
            //gestione eccezione dovuta a input errato
            throw new DAOException("Errore nella generazione del report: " + e.getMessage());
        }

        //restituisce al chiamante il report costruito
        return new Report(dataPartenza,
                dataRientro,
                numeroOspitiTotale,
                costoOperativo,
                costoItinerario,
                itinerario,
                autobusReport,
                albergoReport,
                utenteReport);
    }
}
