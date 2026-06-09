SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AgenziaViaggio
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `AgenziaViaggio` ;

-- -----------------------------------------------------
-- Schema AgenziaViaggio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AgenziaViaggio` DEFAULT CHARACTER SET utf8 ;
USE `AgenziaViaggio` ;

-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Utente` (
    `Username` VARCHAR(16) NOT NULL,
    `NomeUtente` VARCHAR(100) NOT NULL,
    `CognomeUtente` VARCHAR(100) NOT NULL,
    `Password` VARCHAR(100) NOT NULL,
    `Ruolo` ENUM('Cliente', 'Agente') NOT NULL,
    PRIMARY KEY (`Username`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Itinerario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Itinerario` (
    `Nome` VARCHAR(100) NOT NULL,
    `CostoItinerario` DECIMAL(10,2) UNSIGNED NOT NULL,
    PRIMARY KEY (`Nome`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`EdizioneViaggioPassata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`EdizioneViaggioPassata` (
    `Partenza` DATE NOT NULL,
    `Rientro` DATE NOT NULL,
    `NumeroOspitiTotale` INT UNSIGNED NOT NULL,
    `CostoOperativo` DECIMAL(10,2) UNSIGNED NOT NULL,
    `Itinerario` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`Partenza`, `Itinerario`),
    CONSTRAINT `fk_EdizioneViaggioPassata_Itinerario1`
    FOREIGN KEY (`Itinerario`)
    REFERENCES `AgenziaViaggio`.`Itinerario` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_EdizioneViaggioPassata_Itinerario1_idx` ON `AgenziaViaggio`.`EdizioneViaggioPassata` (`Itinerario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`EdizioneViaggioFutura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`EdizioneViaggioFutura` (
    `Partenza` DATE NOT NULL,
    `Rientro` DATE NOT NULL,
    `NumeroOspitiTotale` INT UNSIGNED NOT NULL,
    `CostoOperativo` DECIMAL(10,2) UNSIGNED NOT NULL,
    `Itinerario` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`Partenza`, `Itinerario`),
    CONSTRAINT `fk_EdizioneViaggioFutura_Itinerario1`
    FOREIGN KEY (`Itinerario`)
    REFERENCES `AgenziaViaggio`.`Itinerario` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_EdizioneViaggioFutura_Itinerario1_idx` ON `AgenziaViaggio`.`EdizioneViaggioFutura` (`Itinerario` ASC) VISIBLE;

CREATE INDEX `idx_edizioneViaggioFutura_rientro` ON `AgenziaViaggio`.`EdizioneViaggioFutura` (`Rientro` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Prenotazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Prenotazione` (
    `IDprenotazione` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `NumeroOspitiPrenotazione` INT UNSIGNED NOT NULL,
    `InfoCliente` VARCHAR(16) NOT NULL,
    `PartenzaP` DATE NULL,
    `ItinerarioP` VARCHAR(100) NULL,
    `PartenzaF` DATE NULL,
    `ItinerarioF` VARCHAR(100) NULL,
    PRIMARY KEY (`IDprenotazione`),
    CONSTRAINT `fk_Prenotazione_Cliente`
    FOREIGN KEY (`InfoCliente`)
    REFERENCES `AgenziaViaggio`.`Utente` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_Prenotazione_EdizioneViaggioPassata1`
    FOREIGN KEY (`PartenzaP` , `ItinerarioP`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioPassata` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_Prenotazione_EdizioneViaggioFutura1`
    FOREIGN KEY (`PartenzaF` , `ItinerarioF`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioFutura` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (`NumeroOspitiPrenotazione` > 0),
    CHECK (
(`PartenzaF` IS NOT NULL AND `PartenzaP` IS NULL)
    OR (`PartenzaF` IS NULL AND `PartenzaP` IS NOT NULL)
    ),
    CHECK (
(`ItinerarioF` IS NOT NULL AND `ItinerarioP` IS NULL)
    OR (`ItinerarioF` IS NULL AND `ItinerarioP` IS NOT NULL)
    ))
    ENGINE = InnoDB;

CREATE INDEX `fk_Prenotazione_Cliente_idx` ON `AgenziaViaggio`.`Prenotazione` (`InfoCliente` ASC) VISIBLE;

CREATE INDEX `fk_Prenotazione_EdizioneViaggioPassata1_idx` ON `AgenziaViaggio`.`Prenotazione` (`PartenzaP` ASC, `ItinerarioP` ASC) VISIBLE;

CREATE INDEX `fk_Prenotazione_EdizioneViaggioFutura1_idx` ON `AgenziaViaggio`.`Prenotazione` (`PartenzaF` ASC, `ItinerarioF` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`AutobusAgenzia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`AutobusAgenzia` (
    `IDmezzo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `CostoMezzo` DECIMAL(10,2) UNSIGNED NOT NULL,
    `Capienza` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`IDmezzo`),
    CHECK (`Capienza` > 0))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Citta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Citta` (
    `NomeCitta` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`NomeCitta`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`TappaNotturna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`TappaNotturna` (
    `Numero` INT UNSIGNED NOT NULL,
    `DurataTappa` INT UNSIGNED NOT NULL,
    `Itinerario` VARCHAR(100) NOT NULL,
    `Citta` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`Numero`, `Itinerario`),
    CONSTRAINT `fk_TappaNotturna_Itinerario1`
    FOREIGN KEY (`Itinerario`)
    REFERENCES `AgenziaViaggio`.`Itinerario` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_TappaNotturna_Citta1`
    FOREIGN KEY (`Citta`)
    REFERENCES `AgenziaViaggio`.`Citta` (`NomeCitta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (`DurataTappa` > 0),
    CHECK (`Numero` > 0))
    ENGINE = InnoDB;

CREATE INDEX `fk_TappaNotturna_Itinerario1_idx` ON `AgenziaViaggio`.`TappaNotturna` (`Itinerario` ASC) VISIBLE;

CREATE INDEX `fk_TappaNotturna_Citta1_idx` ON `AgenziaViaggio`.`TappaNotturna` (`Citta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Albergo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Albergo` (
    `NomeAlbergo` VARCHAR(100) NOT NULL,
    `Referente` VARCHAR(100) NOT NULL,
    `CostoNotteOspite` DECIMAL(10,2) UNSIGNED NOT NULL,
    `NumeroMassimoOspiti` INT UNSIGNED NOT NULL,
    `Indirizzo` VARCHAR(255) NOT NULL,
    `Telefono` VARCHAR(20) NOT NULL,
    `Fax` VARCHAR(20) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `Citta` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`NomeAlbergo`, `Citta`),
    CONSTRAINT `fk_Albergo_Citta1`
    FOREIGN KEY (`Citta`)
    REFERENCES `AgenziaViaggio`.`Citta` (`NomeCitta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (`NumeroMassimoOspiti` > 0),
    CHECK (Email LIKE '%@%'))
    ENGINE = InnoDB;

CREATE INDEX `fk_Albergo_Citta1_idx` ON `AgenziaViaggio`.`Albergo` (`Citta` ASC) VISIBLE;

CREATE UNIQUE INDEX `Email_UNIQUE` ON `AgenziaViaggio`.`Albergo` (`Email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`TramiteP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`TramiteP` (
    `Partenza` DATE NOT NULL,
    `Itinerario` VARCHAR(100) NOT NULL,
    `IDmezzo` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`Partenza`, `Itinerario`, `IDmezzo`),
    CONSTRAINT `fk_TramiteP_EdizioneViaggioPassata1`
    FOREIGN KEY (`Partenza` , `Itinerario`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioPassata` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_TramiteP_AutobusAgenzia1`
    FOREIGN KEY (`IDmezzo`)
    REFERENCES `AgenziaViaggio`.`AutobusAgenzia` (`IDmezzo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_TramiteP_AutobusAgenzia1_idx` ON `AgenziaViaggio`.`TramiteP` (`IDmezzo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`TramiteF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`TramiteF` (
    `Partenza` DATE NOT NULL,
    `Itinerario` VARCHAR(100) NOT NULL,
    `IDmezzo` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`Partenza`, `Itinerario`, `IDmezzo`),
    CONSTRAINT `fk_TramiteF_EdizioneViaggioFutura1`
    FOREIGN KEY (`Partenza` , `Itinerario`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioFutura` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_TramiteF_AutobusAgenzia1`
    FOREIGN KEY (`IDmezzo`)
    REFERENCES `AgenziaViaggio`.`AutobusAgenzia` (`IDmezzo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_TramiteF_AutobusAgenzia1_idx` ON `AgenziaViaggio`.`TramiteF` (`IDmezzo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`AlloggioP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`AlloggioP` (
    `EdizioneViaggio` DATE NOT NULL,
    `ItinerarioViaggio` VARCHAR(100) NOT NULL,
    `TappaNotturna` INT UNSIGNED NOT NULL,
    `ItinerarioTappa` VARCHAR(100) NOT NULL,
    `NomeAlbergo` VARCHAR(100) NOT NULL,
    `Citta` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`EdizioneViaggio`, `ItinerarioViaggio`, `TappaNotturna`, `ItinerarioTappa`),
    CONSTRAINT `fk_AlloggioP_EdizioneViaggioPassata1`
    FOREIGN KEY (`EdizioneViaggio` , `ItinerarioViaggio`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioPassata` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_AlloggioP_TappaNotturna1`
    FOREIGN KEY (`TappaNotturna` , `ItinerarioTappa`)
    REFERENCES `AgenziaViaggio`.`TappaNotturna` (`Numero` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_AlloggioP_Albergo1`
    FOREIGN KEY (`NomeAlbergo` , `Citta`)
    REFERENCES `AgenziaViaggio`.`Albergo` (`NomeAlbergo` , `Citta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (`ItinerarioViaggio` = `ItinerarioTappa`))
    ENGINE = InnoDB;

CREATE INDEX `fk_AlloggioP_TappaNotturna1_idx` ON `AgenziaViaggio`.`AlloggioP` (`TappaNotturna` ASC, `ItinerarioTappa` ASC) VISIBLE;

CREATE INDEX `fk_AlloggioP_Albergo1_idx` ON `AgenziaViaggio`.`AlloggioP` (`NomeAlbergo` ASC, `Citta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`AlloggioF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`AlloggioF` (
    `EdizioneViaggio` DATE NOT NULL,
    `ItinerarioViaggio` VARCHAR(100) NOT NULL,
    `TappaNotturna` INT UNSIGNED NOT NULL,
    `ItinerarioTappa` VARCHAR(100) NOT NULL,
    `NomeAlbergo` VARCHAR(100) NOT NULL,
    `Citta` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`EdizioneViaggio`, `ItinerarioViaggio`, `TappaNotturna`, `ItinerarioTappa`),
    CONSTRAINT `fk_AlloggioF_EdizioneViaggioFutura1`
    FOREIGN KEY (`EdizioneViaggio` , `ItinerarioViaggio`)
    REFERENCES `AgenziaViaggio`.`EdizioneViaggioFutura` (`Partenza` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_AlloggioF_TappaNotturna1`
    FOREIGN KEY (`TappaNotturna` , `ItinerarioTappa`)
    REFERENCES `AgenziaViaggio`.`TappaNotturna` (`Numero` , `Itinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_AlloggioF_Albergo1`
    FOREIGN KEY (`NomeAlbergo` , `Citta`)
    REFERENCES `AgenziaViaggio`.`Albergo` (`NomeAlbergo` , `Citta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (`ItinerarioViaggio` = `ItinerarioTappa`))
    ENGINE = InnoDB;

CREATE INDEX `fk_AlloggioF_TappaNotturna1_idx` ON `AgenziaViaggio`.`AlloggioF` (`TappaNotturna` ASC, `ItinerarioTappa` ASC) VISIBLE;

CREATE INDEX `fk_AlloggioF_Albergo1_idx` ON `AgenziaViaggio`.`AlloggioF` (`NomeAlbergo` ASC, `Citta` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- STORED PROCEDURES
-- -----------------------------------------------------

-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`login`
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE login(
    IN p_username VARCHAR(16),
    IN p_password VARCHAR(100),
    OUT p_ruolo INT
)
BEGIN

    -- definizione variabile locale v_ruolo
    DECLARE v_ruolo ENUM('Cliente','Agente');

	-- dichiarazione handler che forza v_ruolo = NULL nel caso in cui le credenziali sono errate
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET v_ruolo = NULL;

    -- ricerca Utente con p_username, p_password e memorizza il suo Ruolo in v_ruolo
    SELECT Ruolo
    INTO v_ruolo
    FROM Utente
    WHERE Username = p_username
      AND Password = p_password;

    -- se non trova nulla (v_ruolo==NULL), viene sollevata una SQLException
    IF v_ruolo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Credenziali non valide';
    END IF;

    -- mapping ENUM->INT, per la costruzione dell'output p_ruolo
    IF v_ruolo = 'Cliente' THEN
        SET p_ruolo = 1;
    ELSEIF v_ruolo = 'Agente' THEN
        SET p_ruolo = 2;
    END IF;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`registraPrenotazione`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE registraPrenotazione(
    IN p_numeroOspiti INT,
    IN p_username VARCHAR(16),
    IN p_partenzaF DATE,
    IN p_itinerarioF VARCHAR(100),
    OUT p_idPrenotazione INT
)
BEGIN
	-- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    -- inizio della transazione
    START TRANSACTION;

        -- inserisce in Prenotazione la tupla definita dai valori in input:
        -- una nuova prenotazione deve sempre riferirsi ad una EdizioneViaggioFutura dunque si forzano PartenzaP, ItinerarioP a NULL
        -- idPrenotazione è autogenerato: viene omesso nell'INSERT
        INSERT INTO Prenotazione (
            NumeroOspitiPrenotazione,
            InfoCliente,
            PartenzaP,
            ItinerarioP,
            PartenzaF,
            ItinerarioF
        )
        VALUES (
           p_numeroOspiti,
           p_username,
           NULL,
           NULL,
           p_partenzaF,
           p_itinerarioF
       );

        -- ritorna al chiamante idPrenotazione che è autogenerato nella BD
        SET p_idPrenotazione = LAST_INSERT_ID();

    -- fine della transazione
    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`cancellaPrenotazione`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE cancellaPrenotazione(
    IN p_idPrenotazione INT,
    IN p_username VARCHAR(16)
)
BEGIN

	-- definizione variabili locali
    DECLARE v_partenza DATE;
    DECLARE v_cliente VARCHAR(16);

    -- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

	-- se la successiva SELECT non trova righe forza v_cliente = NULL rendendo i successivi controlli affidabili
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_cliente = NULL;


    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    -- inizio della transazione
    START TRANSACTION;

        -- recupera i dati della prenotazione in base ad p_idPrenotazione
        SELECT InfoCliente
        INTO v_cliente
        FROM Prenotazione
        WHERE IDprenotazione = p_idPrenotazione;

        -- verifica se la prenotazione esiste
        -- se la prenotazione non esiste, allora v_cliente==NULL
        IF v_cliente IS NULL THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Prenotazione inesistente';
        END IF;

		-- implementazione regola aziendale:
		-- verifica che la prenotazione appartenga al cliente che ne richiede la cancellazione
		IF v_cliente <> p_username THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La prenotazione non appartiene al cliente';
        END IF;

		-- cancellazione della prenotazione identificata da p_idPrenotazione
        DELETE FROM Prenotazione
        WHERE IDprenotazione = p_idPrenotazione;

    -- fine della transazione
    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`registraItinerario`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE registraItinerario(
    IN p_nomeItinerario VARCHAR(100),
    IN p_costo DECIMAL(10,2),
    IN p_tappe TEXT
)
BEGIN

    -- definizione variabili locali
    DECLARE v_numero INT;
    DECLARE v_durata INT;
    DECLARE v_citta VARCHAR(100);
    DECLARE v_pos INT;
    DECLARE v_token TEXT;

	-- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    -- inizio della transazione
    START TRANSACTION;

    -- implementazione regola aziendale:
    -- verifica che l'Itinerario sia composto da almeno una tappa valida
    -- non è valida se (p_tappe == NULL) or (p_tappe eliminando gli spazi == NULL) or (#':' == 0)
        IF p_tappe IS NULL OR LENGTH(TRIM(p_tappe)) = 0 OR LOCATE(':', p_tappe) = 0 THEN
            SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Serve almeno una tappa valida';
        END IF;


		-- registrazione Itinerario
        INSERT INTO Itinerario (Nome, CostoItinerario)
        VALUES (p_nomeItinerario, p_costo);

        -- parsing delle tappe (separate da ';')

        -- continua fino a quando ci sono tappe da leggere
        WHILE LENGTH(p_tappe) > 0 DO
			-- cerca il prossimo blocco (i blocchi sono separati da ';')
			SET v_pos = LOCATE(';', p_tappe);
			-- se non viene trovato nessun ';' allora è l'ultimo blocco:
			IF v_pos = 0 THEN
				-- estrae tutto il contenuto di p_tappe e svuota la stringa
				SET v_token = p_tappe;
				SET p_tappe = '';
			-- se viene trovato un ';' allora è un blocco intermedio:
            ELSE
				-- estrae solo la sottostringa di p_tappe che precede ';'
				SET v_token = SUBSTRING(p_tappe, 1, v_pos - 1);
				-- aggiorna la stringa p_tappe eliminando la parte appena letta
				SET p_tappe = SUBSTRING(p_tappe, v_pos + 1);
            END IF;

			-- parsing interno numero:durata:citta

			-- prende il primo segmento separato da ':'
			SET v_numero = SUBSTRING_INDEX(v_token, ':', 1);
			-- prende i primi 2 segmenti separati da ':'
			-- dal risultato intermedio, prende l'ultimo segmento separato da ':'
			SET v_durata = SUBSTRING_INDEX(SUBSTRING_INDEX(v_token, ':', 2), ':', -1);
			-- prende l'ultimo segmento separato da ':'
			SET v_citta  = SUBSTRING_INDEX(v_token, ':', -1);

			-- inserimento tappa i-esimaa estratta da input serializzato
            INSERT INTO TappaNotturna (
                numero,
                durataTappa,
                itinerario,
                citta
            )
            VALUES (
                v_numero,
                v_durata,
                p_nomeItinerario,
                v_citta
            );
        END WHILE;

    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`registraEdizioneViaggio`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE registraEdizioneViaggio(
    IN p_nomeItinerario VARCHAR(100),
    IN p_dataPartenza DATE,
    IN p_costoOperativo DECIMAL(10,2)
)
BEGIN

    -- definizione variabili locali
    DECLARE v_durataTotale INT;
    DECLARE v_dataRientro DATE;

    -- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    -- inizio della transazione
    START TRANSACTION;

        -- ricavo la durataTotale dell'Itinerario
        -- COALESCE serve a forzare a 0 SUM(DurataTappa) nel caso in cui essa risulta essere NULL
        SELECT COALESCE(SUM(DurataTappa), 0)
        INTO v_durataTotale
        FROM TappaNotturna
        WHERE Itinerario = p_nomeItinerario;

        -- imposta v_dataRientro = p_dataPartenza + v_durataTotale
        SET v_dataRientro =
			DATE_ADD(p_dataPartenza, INTERVAL v_durataTotale DAY);

		-- inserimento della nuova EdizioneViaggioFutura
		-- al momento della creazione, NumeroOspitiTotale == 0 sempre
        INSERT INTO EdizioneViaggioFutura (
            Partenza,
            Rientro,
            NumeroOspitiTotale,
             CostoOperativo,
            Itinerario
        )
        VALUES (
           p_dataPartenza,
           v_dataRientro,
           0,
           p_costoOperativo,
           p_nomeItinerario
       );

    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`registraAlbergo`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE registraAlbergo(
    IN p_nomeAlbergo VARCHAR(100),
    IN p_referente VARCHAR(100),
    IN p_costoNotteOspite DECIMAL(10,2),
    IN p_numeroMassimoOspiti INT,
    IN p_indirizzo VARCHAR(255),
    IN p_telefono VARCHAR(20),
    IN p_fax VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_citta VARCHAR(100)
)
BEGIN

    -- inserimento del nuovo Albergo
    INSERT INTO Albergo (
        NomeAlbergo,
        Referente,
        CostoNotteOspite,
        NumeroMassimoOspiti,
        Indirizzo,
        Telefono,
        Fax,
        Email,
        Citta
    )
    VALUES (
        p_nomeAlbergo,
        p_referente,
        p_costoNotteOspite,
        p_numeroMassimoOspiti,
        p_indirizzo,
        p_telefono,
        p_fax,
        p_email,
        p_citta
    );

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`registraAutobusAgenzia`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE registraAutobusAgenzia(
    IN p_costoMezzo DECIMAL(10,2),
    IN p_capienza INT,
    OUT p_idMezzo INT
)
BEGIN
    -- inserimento del nuovo AutobusAgenzia
    -- l'attributo idMezzo è autogenerato nel DB
    INSERT INTO AutobusAgenzia (
        CostoMezzo,
        Capienza
    )
    VALUES (
        p_costoMezzo,
        p_capienza
    );

    -- setting valore restituito in output
    SET p_idMezzo = LAST_INSERT_ID();

    END $$

    DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`associaAutobusAgenzia`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE associaAutobusAgenzia(
    IN p_idmezzo INT,
    IN p_itinerario VARCHAR(100),
    IN p_partenza DATE,
    OUT p_capienzaTotale INT,
    OUT p_numeroOspitiTotale INT
)
BEGIN

    -- dichiarazione variabili locali
    DECLARE v_rientro DATE;

    -- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    -- inizio della transazione
    START TRANSACTION;

        -- inserimento nuova occorrenza di TramiteF
        INSERT INTO TramiteF (Partenza, Itinerario, IDmezzo)
        VALUES (p_partenza, p_itinerario, p_idmezzo);

        -- calcolo della capienza totale (sommatoria delle capienze di ogni Autobus associato all'EdizioneViaggioFutura)
        SELECT COALESCE(SUM(A.Capienza), 0)
        INTO p_capienzaTotale
        FROM TramiteF TF
        JOIN AutobusAgenzia A ON A.IDmezzo = TF.IDmezzo
        WHERE TF.Partenza = p_partenza
          AND TF.Itinerario = p_itinerario;

        -- recupero da EdizioneViaggioFutura del NumeroOspitiTotale
        SELECT NumeroOspitiTotale
        INTO p_numeroOspitiTotale
        FROM EdizioneViaggioFutura
        WHERE Partenza = p_partenza
          AND Itinerario = p_itinerario;


        -- implementazione regola aziendale:
        -- l'output restituito serve ad implementare la stampa di un warning nel caso in cui:
        -- p_numeroOspitiTotale > p_capienzaTotale

    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`associaAlbergo`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE associaAlbergo(
    IN p_itinerario VARCHAR(100),
    IN p_partenza DATE,
    IN p_numeroTappa INT,
    IN p_citta VARCHAR(100),
    IN p_nomeAlbergo VARCHAR(100)
)
BEGIN

   -- gestione errori: se qualcosa fallisce -> rollback e resignal
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    -- inizio della transazione
    START TRANSACTION;

        -- inserimento nuova occorrenza di AlloggioF
        INSERT INTO AlloggioF(
            EdizioneViaggio,
            ItinerarioViaggio,
            TappaNotturna,
            ItinerarioTappa,
            NomeAlbergo,
            Citta
        )
        VALUES(
            p_partenza,
            p_itinerario,
            p_numeroTappa,
            p_itinerario,
            p_nomeAlbergo,
            p_citta
        );

    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- stored procedure `AgenziaViaggio`.`generaReport`
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE generaReport(
    IN p_itinerario VARCHAR(100),
    IN p_partenza DATE
)
BEGIN

    -- verifica l'esistenza dell'EdizioneViaggioPassata
    IF NOT EXISTS (
        SELECT 1
        FROM EdizioneViaggioPassata
        WHERE Itinerario = p_itinerario
          AND Partenza = p_partenza
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Edizione di viaggio inesistente';
    END IF;

    -- resultSet 1: informazioni utenti e relative prenotazioni
    SELECT
        u.Username,
        u.NomeUtente,
        u.CognomeUtente,
        p.IDprenotazione,
        p.NumeroOspitiPrenotazione
    FROM Prenotazione p
    JOIN Utente u ON u.Username = p.InfoCliente
    WHERE p.ItinerarioP = p_itinerario
      AND p.PartenzaP = p_partenza;

    -- resultSet 2: informazioni alberghi
    SELECT
        a.NomeAlbergo,
        a.CostoNotteOspite,
        tn.DurataTappa
    FROM AlloggioP ap
    JOIN Albergo a
      ON a.NomeAlbergo = ap.NomeAlbergo
     AND a.Citta = ap.Citta
    JOIN TappaNotturna tn
      ON tn.Numero = ap.TappaNotturna
     AND tn.Itinerario = ap.ItinerarioTappa
    WHERE ap.ItinerarioViaggio = p_itinerario
      AND ap.EdizioneViaggio = p_partenza;

    -- resultSet 3: informazioni autobus
    SELECT
        au.IDmezzo,
        au.CostoMezzo
    FROM TramiteP tp
    JOIN AutobusAgenzia au
      ON au.IDmezzo = tp.IDmezzo
    WHERE tp.Itinerario = p_itinerario
      AND tp.Partenza = p_partenza;

    -- resultSet 4: informazioni EdizioneViaggioPassata
    SELECT
        ev.Rientro,
        ev.NumeroOspitiTotale,
        ev.CostoOperativo,
        i.CostoItinerario
    FROM EdizioneViaggioPassata ev
    JOIN Itinerario i
      ON i.Nome = ev.Itinerario
    WHERE ev.Itinerario = p_itinerario
      AND ev.Partenza = p_partenza;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Trigger attivati da `AgenziaViaggio`.`registraPrenotazione`
-- -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER trg_check_prenotazione_data
    BEFORE INSERT ON Prenotazione
    FOR EACH ROW
BEGIN
    -- implementazione regola aziendale:
    -- verifica che l'inserimento della prenotazione sia inerente un viaggio con partenza prevista tra >=20 giorni
    IF DATEDIFF(NEW.PartenzaF, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Prenotazione non consentita: meno di 20 giorni alla partenza';
END IF;

END $$

DELIMITER;

DELIMITER $$

CREATE TRIGGER trg_update_ospiti_after_insert
    AFTER INSERT ON Prenotazione
    FOR EACH ROW
BEGIN

    -- aggiorna il totale ospiti dell'edizione futura associata alla nuova prenotazione registrata
    UPDATE EdizioneViaggioFutura
    SET NumeroOspitiTotale = COALESCE(NumeroOspitiTotale, 0) + NEW.NumeroOspitiPrenotazione
    WHERE Partenza = NEW.PartenzaF
      AND Itinerario = NEW.ItinerarioF;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- Triggers attivati da `AgenziaViaggio`.`cancellaPrenotazione`
-- -----------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_check_delete_prenotazione
    BEFORE DELETE ON Prenotazione
    FOR EACH ROW
BEGIN

    DECLARE v_partenza DATE;

    -- sceglie se usare PartenzaF o PartenzaP nel controllo in base a quale delle due è NULL
	SET v_partenza = COALESCE(OLD.PartenzaF, OLD.PartenzaP);

	-- implementazione regola aziendale:
    -- verifica che la cancellazione della prenotazione sia inerente un viaggio con partenza prevista tra >=20 giorni
    IF DATEDIFF(v_partenza, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Cancellazione non consentita: meno di 20 giorni alla partenza';
    END IF;

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_update_ospiti_after_delete
    AFTER DELETE ON Prenotazione
    FOR EACH ROW
BEGIN

    -- aggiorna il totale ospiti dell'edizione futura associata alla prenotazione cancellata
    UPDATE EdizioneViaggioFutura
    SET NumeroOspitiTotale = COALESCE(NumeroOspitiTotale, 0) - OLD.NumeroOspitiPrenotazione
    WHERE Partenza = OLD.PartenzaF
      AND Itinerario = OLD.ItinerarioF;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- Triggers attivati da `AgenziaViaggio`.`registraEdizioneViaggio`
-- -----------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_check_data_partenza
    BEFORE INSERT ON EdizioneViaggioFutura
    FOR EACH ROW
BEGIN
    -- verifica che la data della partenza sia tra >=20 giorni:
    -- vincolo che è diretta conseguenza della regola aziendale secondo la quale
    -- è possibile effettuare prenotazioni quando mancano >=20 giorni alla partenza
    IF DATEDIFF(NEW.Partenza, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La data di partenza deve essere almeno 20 giorni successiva alla data odierna';
    END IF;
END $$

DELIMITER ;


-- -----------------------------------------------------
-- Trigger attivati da `AgenziaViaggio`.`associaAutobusAgenzia`
-- -----------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_check_tramitef_inserimento
BEFORE INSERT ON TramiteF
FOR EACH ROW
BEGIN

    DECLARE v_rientro DATE;

    -- recupero Rientro dell’edizione su cui si sta inserendo l’autobus
    SELECT EV.Rientro
    INTO v_rientro
    FROM EdizioneViaggioFutura EV
    WHERE EV.Partenza = NEW.Partenza
      AND EV.Itinerario = NEW.Itinerario;

    -- Verifica esistenza edizione
    IF v_rientro IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'EdizioneViaggioFutura non valida';
    END IF;

    -- Vincolo temporale: Partenza non nel passato
    IF DATEDIFF(NEW.Partenza, CURDATE()) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data di partenza già trascorsa';
    END IF;

    -- Vincolo temporale: Partenza a meno di 20 giorni dalla data corrente
    IF DATEDIFF(NEW.Partenza, CURDATE()) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Associazione non consentita: più di 20 giorni alla partenza';
    END IF;

    -- Vincolo di sovrapposizione autobus
    IF EXISTS (
        SELECT 1
        FROM TramiteF TF
        JOIN EdizioneViaggioFutura EV2
          ON TF.Partenza = EV2.Partenza
         AND TF.Itinerario = EV2.Itinerario
        WHERE TF.IDmezzo = NEW.IDmezzo
          AND NOT (
              EV2.Rientro < NEW.Partenza
              OR EV2.Partenza > v_rientro
          )
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Autobus già assegnato a un viaggio sovrapposto';
    END IF;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- Trigger attivati da `AgenziaViaggio`.`associaAlbergo`
-- -----------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_check_alloggiof_inserimento
BEFORE INSERT ON AlloggioF
FOR EACH ROW
BEGIN

    DECLARE v_cittaTappa VARCHAR(100);
    DECLARE v_cittaAlbergo VARCHAR(100);

    DECLARE v_numeroOspiti INT;
    DECLARE v_capienza INT;

    DECLARE v_dataPartenza DATE;

    -- recupero dati dell'EdizioneViaggioFutura
    SELECT EV.Partenza, EV.NumeroOspitiTotale
    INTO v_dataPartenza, v_numeroOspiti
    FROM EdizioneViaggioFutura EV
    WHERE EV.Partenza = NEW.EdizioneViaggio
      AND EV.Itinerario = NEW.ItinerarioViaggio;

    -- verifica esistenza dell'EdizioneViaggioFutura
    IF v_dataPartenza IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'EdizioneViaggioFutura non valida';
    END IF;

    -- implementazione regola aziendale:
    -- verifica che che l'associazione sia inerente un'EdizioneViaggioFutura con partenza prevista tra 0 e 20 giorni
    IF DATEDIFF(v_dataPartenza, CURDATE()) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data di partenza già trascorsa';
    END IF;

    IF DATEDIFF(v_dataPartenza, CURDATE()) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Associazione non consentita: più di 20 giorni alla partenza';
    END IF;

    -- recupero città della TappaNotturna
    SELECT Citta
    INTO v_cittaTappa
    FROM TappaNotturna
    WHERE Numero = NEW.TappaNotturna
      AND Itinerario = NEW.ItinerarioTappa;

    -- verifica esistenza della TappaNotturna
    IF v_cittaAlbergo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tappa notturna non valida';
    END IF;

    -- recupero dati dell'Albergo
    SELECT Citta, NumeroMassimoOspiti
    INTO v_cittaAlbergo, v_capienza
    FROM Albergo
    WHERE NomeAlbergo = NEW.NomeAlbergo
      AND Citta = NEW.Citta;

    -- verifica esistenza dell'albergo
    IF v_cittaAlbergo IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Albergo non valido';
    END IF;

    -- implementazione regola aziendale:
    -- verifica che v_cittaTappa, v_cittaAlbergo siano uguali
    IF v_cittaTappa <> v_cittaAlbergo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Albergo non coerente con la città della tappa';
    END IF;

    -- implementazione regola aziendale:
    -- verifica che la capienza dell'Albergo sia <= del NumeroOspitiTotale
    IF v_capienza <= v_numeroOspiti THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Capienza albergo insufficiente rispetto agli ospiti dell’edizione';
    END IF;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- EVENTS
-- -----------------------------------------------------

-- attivazione dello scheduler degli eventi
SET GLOBAL event_scheduler = ON;

-- -----------------------------------------------------
-- event `AgenziaViaggio`.`spostaEdizioniPassate`
-- -----------------------------------------------------

DELIMITER $$

CREATE EVENT spostaEdizioniPassate
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN

    -- handler che implementa rollback e pulizia temporary table nel caso in cui la transazione non va a buon fine
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
        ROLLBACK;
        DROP TEMPORARY TABLE IF EXISTS tmp_edizioni;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    -- inizio transazione
    START TRANSACTION;

    -- creazione temporary table in cui memorizzare le EdizioneViaggioFutura tali che Rientro < CURDATE()
    -- necessario per garantire che tutte le operazioni lavorino sullo stesso insieme di tuple
    CREATE TEMPORARY TABLE tmp_edizioni AS
    SELECT
        Partenza,
        Itinerario
    FROM EdizioneViaggioFutura
    WHERE Rientro < CURDATE();


    -- copia delle EdizioneViaggioFutura, presenti in tmp_edizioni, in EdizioneViaggioPassata
    INSERT INTO EdizioneViaggioPassata
    (
        Partenza,
        Rientro,
        NumeroOspitiTotale,
        CostoOperativo,
        Itinerario
    )
    SELECT
        ev.Partenza,
        ev.Rientro,
        ev.NumeroOspitiTotale,
        ev.CostoOperativo,
        ev.Itinerario
    FROM EdizioneViaggioFutura ev
    JOIN tmp_edizioni t
      ON ev.Partenza = t.Partenza
     AND ev.Itinerario = t.Itinerario;

    -- aggiornamento istanze di Prenotazioni con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni
    UPDATE Prenotazione p
    JOIN tmp_edizioni t
      ON p.PartenzaF = t.Partenza
     AND p.ItinerarioF = t.Itinerario
    SET
        p.PartenzaP = p.PartenzaF,
        p.ItinerarioP = p.ItinerarioF,
        p.PartenzaF = NULL,
        p.ItinerarioF = NULL;

    -- copia delle occorrenze di TramiteF, con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni, in TramiteP
    INSERT INTO TramiteP
    (
        Partenza,
        Itinerario,
        IDmezzo
    )
    SELECT
        tf.Partenza,
        tf.Itinerario,
        tf.IDmezzo
    FROM TramiteF tf
    JOIN tmp_edizioni t
      ON tf.Partenza = t.Partenza
     AND tf.Itinerario = t.Itinerario;

    -- copia delle occorrenze di AlloggioF, con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni, in AlloggioP
    INSERT INTO AlloggioP
    (
        EdizioneViaggio,
        ItinerarioViaggio,
        TappaNotturna,
        ItinerarioTappa,
        NomeAlbergo,
        Citta
    )
    SELECT
        af.EdizioneViaggio,
        af.ItinerarioViaggio,
        af.TappaNotturna,
        af.ItinerarioTappa,
        af.NomeAlbergo,
        af.Citta
    FROM AlloggioF af
    JOIN tmp_edizioni t
      ON af.EdizioneViaggio = t.Partenza
     AND af.ItinerarioViaggio = t.Itinerario;

    -- cancellazione delle occorrenze di TramiteF copiate in TramiteP
    DELETE tf
    FROM TramiteF tf
    JOIN tmp_edizioni t
      ON tf.Partenza = t.Partenza
     AND tf.Itinerario = t.Itinerario;

	-- cancellazione delle occorrenze di AlloggioF copiate in AlloggioP
    DELETE af
    FROM AlloggioF af
    JOIN tmp_edizioni t
      ON af.EdizioneViaggio = t.Partenza
     AND af.ItinerarioViaggio = t.Itinerario;

	-- cancellazione delle occorrenze di EdizioneViaggioFutura copiate in EdizioneViaggioPassata
    DELETE ev
    FROM EdizioneViaggioFutura ev
    JOIN tmp_edizioni t
      ON ev.Partenza = t.Partenza
     AND ev.Itinerario = t.Itinerario;

	-- pulizia e deallocazione temporary table
    DROP TEMPORARY TABLE IF EXISTS tmp_edizioni;

	-- commit della transazione
    COMMIT;

END $$

DELIMITER ;


-- -----------------------------------------------------
-- USERS AND PRIVILEGES
-- -----------------------------------------------------

DROP USER IF EXISTS 'login';
CREATE USER 'login' IDENTIFIED BY 'login';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`login` TO 'login';

DROP USER IF EXISTS 'cliente';
CREATE USER 'cliente' IDENTIFIED BY 'cliente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`registraPrenotazione` TO 'cliente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`cancellaPrenotazione` TO 'cliente';

DROP USER IF EXISTS 'agente';
CREATE USER 'agente' IDENTIFIED BY 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`registraItinerario` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`registraEdizioneViaggio` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`registraAlbergo` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`registraAutobusAgenzia` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`associaAutobusAgenzia` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`associaAlbergo` TO 'agente';
GRANT EXECUTE ON procedure `AgenziaViaggio`.`generaReport` TO 'agente';


-- -----------------------------------------------------
-- DEFAULT DATA FOR THE EXAMPLE PROGRAM
-- -----------------------------------------------------

INSERT INTO Utente VALUES
                       ('mrossi','Mario','Rossi','1234','Cliente'),
                       ('lbianchi','Luisa','Bianchi','pass','Cliente'),
                       ('gverdi','Giuseppe','Verdi','pass','Cliente'),
                       ('fneri','Francesca','Neri','pass','Cliente'),
                       ('dconti','Davide','Conti','pass','Cliente'),
                       ('srosa','Sara','Rosa','pass','Cliente'),
                       ('vverdi','Valeria','Verdi','pass','Cliente'),
                       ('tneri','Tommaso','Neri','pass','Cliente'),

                       ('aadmin','Alberto','Admin','admin','Agente'),
                       ('sconti','Silvia','Conti','agent','Agente'),
                       ('mbruni','Marco','Bruni','agent','Agente'),
                       ('lrusso','Luca','Russo','agent','Agente'),
                       ('gbianchi','Giulia','Bianchi','agent','Agente'),
                       ('pneri','Paolo','Neri','agent','Agente'),
                       ('fverdi','Federica','Verdi','agent','Agente');

INSERT INTO Citta VALUES
                      ('Roma'),
                      ('Milano'),
                      ('Firenze'),
                      ('Venezia'),
                      ('Napoli'),
                      ('Torino'),
                      ('Bologna'),
                      ('Verona'),
                      ('Pisa'),
                      ('Genova'),
                      ('Bari'),
                      ('Palermo'),
                      ('Siena'),
                      ('Lecce'),
                      ('Parma');

INSERT INTO Itinerario VALUES
                           ('ItaliaNord', 1200),
                           ('ItaliaSud', 1100),
                           ('ArteToscana', 900),
                           ('LaghiNord', 800),
                           ('CittaVenete', 700),
                           ('SiciliaTour', 1300),
                           ('RomaClassica', 600),
                           ('Costiera', 1000),
                           ('FoodTour', 850),
                           ('MareAdriatico', 950),
                           ('MareTirreno', 950),
                           ('Dolomiti', 1400),
                           ('PugliaTour', 1200),
                           ('EmiliaRomagna', 750),
                           ('GrandTourItalia', 2000),

                           ('TestScaduto', 1200);

INSERT INTO AutobusAgenzia (CostoMezzo, Capienza) VALUES
                                                      (5000,50),
                                                      (5200,50),
                                                      (4800,45),
                                                      (6000,55),
                                                      (6100,55),
                                                      (4500,40),
                                                      (7000,60),
                                                      (7200,60),
                                                      (5300,50),
                                                      (4900,45),
                                                      (8000,65),
                                                      (8100,65),
                                                      (5600,50),
                                                      (5700,50),
                                                      (6000,55);

INSERT INTO EdizioneViaggioFutura VALUES
                                      -- ('2026-06-20','2026-06-25',60,3800,'Dolomiti'),
                                      -- ('2026-06-23','2026-06-30',115,4200,'RomaClassica'),
                                      -- ('2026-06-26','2026-07-03',90,3800,'LaghiNord'),

                                      ('2026-07-01','2026-07-10',15,5000,'ItaliaNord'),
                                      ('2026-07-05','2026-07-12',0,4800,'ItaliaSud'),
                                      ('2026-07-10','2026-07-18',0,4200,'ArteToscana'),
                                      ('2026-07-20','2026-07-28',0,3800,'CittaVenete'),
                                      ('2026-08-01','2026-08-10',0,6000,'SiciliaTour'),
                                      ('2026-08-05','2026-08-12',0,3000,'RomaClassica'),
                                      ('2026-08-10','2026-08-18',0,4500,'Costiera'),
                                      ('2026-08-15','2026-08-22',0,3500,'FoodTour'),
                                      ('2026-08-20','2026-08-28',0,4200,'MareAdriatico'),
                                      ('2026-09-01','2026-09-10',0,4200,'MareTirreno'),
                                      ('2026-09-05','2026-09-15',0,7000,'Dolomiti'),
                                      ('2026-09-10','2026-09-18',0,5500,'PugliaTour'),
                                      ('2026-09-15','2026-09-22',0,4000,'EmiliaRomagna'),
                                      ('2026-09-20','2026-09-30',0,9000,'GrandTourItalia');

-- ('2026-05-01','2026-05-05',30,2000,'TestScaduto');

INSERT INTO EdizioneViaggioPassata VALUES
                                       ('2025-03-05','2025-03-15',55,7000,'Dolomiti'),
                                       ('2025-02-05','2025-02-12',25,3000,'RomaClassica'),
                                       ('2025-01-15','2025-01-22',45,4000,'LaghiNord'),

                                       ('2025-01-01','2025-01-10',40,5000,'ItaliaNord'),
                                       ('2025-01-05','2025-01-12',35,4800,'ItaliaSud'),
                                       ('2025-01-10','2025-01-18',30,4200,'ArteToscana'),
                                       ('2025-01-20','2025-01-28',38,3800,'CittaVenete'),
                                       ('2025-02-01','2025-02-10',50,6000,'SiciliaTour'),
                                       ('2025-02-10','2025-02-18',42,4500,'Costiera'),
                                       ('2025-02-15','2025-02-22',28,3500,'FoodTour'),
                                       ('2025-02-20','2025-02-28',33,4200,'MareAdriatico'),
                                       ('2025-03-01','2025-03-10',31,4200,'MareTirreno'),
                                       ('2025-03-10','2025-03-18',47,5500,'PugliaTour'),
                                       ('2025-03-15','2025-03-22',39,4000,'EmiliaRomagna'),
                                       ('2025-03-20','2025-03-30',50,9000,'GrandTourItalia');

INSERT INTO TappaNotturna VALUES
                              (1,2,'Dolomiti','Milano'),
                              (2,2,'Dolomiti','Verona'),
                              (3,1,'Dolomiti','Torino'),
                              (1,7,'RomaClassica','Roma'),
                              (1,4,'LaghiNord','Venezia'),
                              (2,3,'LaghiNord','Verona'),

                              (1,5,'ItaliaNord','Milano'),
                              (2,4,'ItaliaNord','Torino'),
                              (1,7,'ItaliaSud','Napoli'),
                              (1,8,'ArteToscana','Firenze'),
                              (1,8,'CittaVenete','Venezia'),
                              (1,9,'SiciliaTour','Palermo'),
                              (1,8,'Costiera','Napoli'),
                              (1,7,'FoodTour','Parma'),
                              (1,8,'MareAdriatico','Bari'),
                              (1,9,'MareTirreno','Genova'),
                              (1,8,'PugliaTour','Lecce'),
                              (1,7,'EmiliaRomagna','Bologna'),
                              (1,10,'GrandTourItalia','Roma'),

                              (1, 2, 'TestScaduto', 'Roma');

INSERT INTO Albergo VALUES
                        ('Hotel Milano','Marco',100,100,'Via Roma 1','111','111','milano@h.it','Milano'),
                        ('Hotel Torino','Marco',90,80,'Via Torino 1','222','222','torino@h.it','Torino'),
                        ('Hotel Napoli','Marco',80,90,'Via Napoli 1','333','333','napoli@h.it','Napoli'),
                        ('Hotel Firenze','Marco',120,70,'Via Firenze 1','444','444','firenze@h.it','Firenze'),
                        ('Hotel Venezia','Marco',150,60,'Via Venezia 1','555','555','venezia@h.it','Venezia'),
                        ('Grande Hotel Venezia','Marco',330,220,'Via Venezia 1','555','555','granvenezia@h.it','Venezia'),
                        ('Hotel Palermo','Marco',110,85,'Via Palermo 1','666','666','palermo@h.it','Palermo'),
                        ('Hotel Roma','Marco',130,120,'Via Roma 2','777','777','roma@h.it','Roma'),
                        ('Grande Hotel Roma','Marco',450,260,'Via Roma 4','707','707','granroma@h.it','Roma'),
                        ('Hotel Bari','Marco',95,75,'Via Bari 1','888','888','bari@h.it','Bari'),
                        ('Hotel Lecce','Marco',85,60,'Via Lecce 1','999','999','lecce@h.it','Lecce'),
                        ('Hotel Parma','Marco',90,65,'Via Parma 1','101','101','parma@h.it','Parma'),
                        ('Hotel Bologna','Marco',100,80,'Via Bologna 1','102','102','bologna@h.it','Bologna'),
                        ('Hotel Verona','Marco',110,70,'Via Verona 1','103','103','verona@h.it','Verona'),
                        ('Hotel Pisa','Marco',95,60,'Via Pisa 1','104','104','pisa@h.it','Pisa'),
                        ('Hotel Genova','Marco',120,90,'Via Genova 1','105','105','genova@h.it','Genova'),
                        ('Hotel Siena','Marco',115,75,'Via Siena 1','106','106','siena@h.it','Siena');

INSERT INTO Prenotazione (NumeroOspitiPrenotazione, InfoCliente, PartenzaF, ItinerarioF)
VALUES
    -- prenotazioni inerenti edizioni future:
    -- (25,'fneri','2026-06-20','Dolomiti'),
    -- (15,'srosa','2026-06-20','Dolomiti'),
    -- (20,'tneri','2026-06-20','Dolomiti'),

    -- (25,'dconti','2026-06-23','RomaClassica'),
    -- (35,'lbianchi','2026-06-23','RomaClassica'),
    -- (20,'tneri','2026-06-23','RomaClassica'),
    -- (15,'srosa','2026-06-23','RomaClassica'),
    -- (20,'gverdi','2026-06-23','RomaClassica'),

    -- (35,'dconti','2026-06-26','LaghiNord'),
    -- (25,'srosa','2026-06-26','LaghiNord'),
    -- (30,'vverdi','2026-06-26','LaghiNord'),

    (15,'vverdi','2026-07-01','ItaliaNord');

-- (10, 'fneri', '2026-05-01', 'TestScaduto'),
-- (20, 'srosa', '2026-05-01', 'TestScaduto');

INSERT INTO Prenotazione (NumeroOspitiPrenotazione, InfoCliente, PartenzaP, ItinerarioP)
VALUES
    -- prenotazioni inerenti edizioni passate:
    (25,'fneri','2025-03-05','Dolomiti'),
    (15,'dconti','2025-03-05','Dolomiti'),
    (15,'gverdi','2025-03-05','Dolomiti'),

    (15,'vverdi','2025-02-05','RomaClassica'),
    (10,'srosa','2025-02-05','RomaClassica'),

    (10,'mrossi','2025-01-15','LaghiNord'),
    (5,'lbianchi','2025-01-15','LaghiNord'),
    (10,'gverdi','2025-01-15','LaghiNord'),
    (10,'tneri','2025-01-15','LaghiNord'),

    (40,'srosa','2025-01-01','ItaliaNord'),
    (35,'lbianchi','2025-01-05','ItaliaSud'),
    (30,'gverdi','2025-01-10','ArteToscana'),
    (38,'dconti','2025-01-20','CittaVenete'),
    (50,'srosa','2025-02-01','SiciliaTour'),
    (42,'tneri','2025-02-10','Costiera'),
    (28,'mrossi','2025-02-15','FoodTour'),
    (33,'lbianchi','2025-02-20','MareAdriatico'),
    (31,'gverdi','2025-03-01','MareTirreno'),
    (47,'dconti','2025-03-10','PugliaTour'),
    (39,'srosa','2025-03-15','EmiliaRomagna'),
    (50,'vverdi','2025-03-20','GrandTourItalia');

INSERT INTO TramiteP VALUES
                         ('2025-01-01','ItaliaNord',1),
                         ('2025-01-05','ItaliaSud',2),
                         ('2025-01-10','ArteToscana',3),
                         ('2025-01-15','LaghiNord',4),
                         ('2025-01-20','CittaVenete',5),
                         ('2025-02-01','SiciliaTour',12),
                         ('2025-02-05','RomaClassica',7),
                         ('2025-02-10','Costiera',8),
                         ('2025-02-15','FoodTour',9),
                         ('2025-02-20','MareAdriatico',10),
                         ('2025-03-01','MareTirreno',11),
                         ('2025-03-05','Dolomiti',12),
                         ('2025-03-10','PugliaTour',13),
                         ('2025-03-15','EmiliaRomagna',14),
                         ('2025-03-20','GrandTourItalia',15);

-- INSERT INTO TramiteF VALUES
-- ('2026-06-20','Dolomiti',12),

-- ('2026-05-01', 'TestScaduto', 1),
-- ('2026-05-01', 'TestScaduto', 2);
-- TramiteF inerenti:
-- ('2026-06-23','2026-06-30',275,4200,'RomaClassica'),
-- ('2026-06-26','2026-07-03',120,3800,'LaghiNord')
-- non sono volutamente ancora stati inseriti

INSERT INTO AlloggioP VALUES
                          ('2025-03-05','Dolomiti',1,'Dolomiti','Hotel Milano','Milano'),
                          ('2025-03-05','Dolomiti',2,'Dolomiti','Hotel Verona','Verona'),
                          ('2025-03-05','Dolomiti',3,'Dolomiti','Hotel Torino','Torino'),

                          ('2025-02-05','RomaClassica',1,'RomaClassica','Hotel Roma','Roma'),

                          ('2025-01-15','LaghiNord',1,'LaghiNord','Hotel Venezia','Venezia'),
                          ('2025-01-15','LaghiNord',2,'LaghiNord','Hotel Verona','Verona'),

                          ('2025-01-01','ItaliaNord',1,'ItaliaNord','Hotel Milano','Milano'),
                          ('2025-01-01','ItaliaNord',2,'ItaliaNord','Hotel Torino','Torino'),
                          ('2025-01-05','ItaliaSud',1,'ItaliaSud','Hotel Napoli','Napoli'),
                          ('2025-01-10','ArteToscana',1,'ArteToscana','Hotel Firenze','Firenze'),
                          ('2025-01-20','CittaVenete',1,'CittaVenete','Hotel Venezia','Venezia'),
                          ('2025-02-01','SiciliaTour',1,'SiciliaTour','Hotel Palermo','Palermo'),
                          ('2025-02-10','Costiera',1,'Costiera','Hotel Napoli','Napoli'),
                          ('2025-02-15','FoodTour',1,'FoodTour','Hotel Parma','Parma'),
                          ('2025-02-20','MareAdriatico',1,'MareAdriatico','Hotel Bari','Bari'),
                          ('2025-03-01','MareTirreno',1,'MareTirreno','Hotel Genova','Genova'),
                          ('2025-03-10','PugliaTour',1,'PugliaTour','Hotel Lecce','Lecce'),
                          ('2025-03-15','EmiliaRomagna',1,'EmiliaRomagna','Hotel Bologna','Bologna');

-- INSERT INTO AlloggioF VALUES
--                       ('2026-06-20','Dolomiti',1,'Dolomiti','Hotel Milano','Milano'),
--                       ('2026-06-20','Dolomiti',2,'Dolomiti','Hotel Verona','Verona'),
--                       ('2026-06-20','Dolomiti',3,'Dolomiti','Hotel Torino','Torino');
-- AlloggioF inerenti:
-- ('2026-06-23','2026-06-30',275,4200,'RomaClassica'),
-- ('2026-06-26','2026-07-03',120,3800,'LaghiNord')
-- non sono volutamente ancora stati inseriti


-- TEST EVENTI

-- DELIMITER $$

-- CREATE PROCEDURE TestSpostaEdizioni()
-- BEGIN

-- handler che implementa rollback e pulizia temporary table nel caso in cui la transazione non va a buon fine
--     DECLARE EXIT HANDLER FOR SQLEXCEPTION
--    BEGIN
--        ROLLBACK;
--        DROP TEMPORARY TABLE IF EXISTS tmp_edizioni;
--    END;

-- inizio transazione
--   START TRANSACTION;

-- creazione temporary table in cui memorizzare le EdizioneViaggioFutura tali che Rientro < CURDATE()
-- necessario per garantire che tutte le operazioni lavorino sullo stesso insieme di tuple
--    CREATE TEMPORARY TABLE tmp_edizioni AS
--    SELECT
--        Partenza,
--        Itinerario
--    FROM EdizioneViaggioFutura
--    WHERE Rientro < CURDATE();


-- copia delle EdizioneViaggioFutura, presenti in tmp_edizioni, in EdizioneViaggioPassata
--    INSERT INTO EdizioneViaggioPassata
--    (
--        Partenza,
--        Rientro,
--        NumeroOspitiTotale,
--        CostoOperativo,
--        Itinerario
--    )
--    SELECT
--        ev.Partenza,
--        ev.Rientro,
--        ev.NumeroOspitiTotale,
--        ev.CostoOperativo,
--        ev.Itinerario
--    FROM EdizioneViaggioFutura ev
--    JOIN tmp_edizioni t
--      ON ev.Partenza = t.Partenza
--     AND ev.Itinerario = t.Itinerario;

-- aggiornamento istanze di Prenotazioni con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni
--    UPDATE Prenotazione p
--    JOIN tmp_edizioni t
--      ON p.PartenzaF = t.Partenza
--     AND p.ItinerarioF = t.Itinerario
--    SET
--        p.PartenzaP = p.PartenzaF,
--        p.ItinerarioP = p.ItinerarioF,
--        p.PartenzaF = NULL,
--        p.ItinerarioF = NULL;

-- copia delle occorrenze di TramiteF, con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni, in TramiteP
--    INSERT INTO TramiteP
--    (
--        Partenza,
--        Itinerario,
--        IDmezzo
--    )
--    SELECT
--        tf.Partenza,
-- 	tf.Itinerario,
--        tf.IDmezzo
--    FROM TramiteF tf
--    JOIN tmp_edizioni t
--      ON tf.Partenza = t.Partenza
--     AND tf.Itinerario = t.Itinerario;

-- copia delle occorrenze di AlloggioF, con FK inerenti EdizioneViaggioFutura presenti in tmp_edizioni, in AlloggioP
--    INSERT INTO AlloggioP
--    (
--        EdizioneViaggio,
--        ItinerarioViaggio,
--        TappaNotturna,
--        ItinerarioTappa,
--        NomeAlbergo,
--        Citta
--    )
--    SELECT
--        af.EdizioneViaggio,
--        af.ItinerarioViaggio,
--        af.TappaNotturna,
--        af.ItinerarioTappa,
--        af.NomeAlbergo,
--        af.Citta
--    FROM AlloggioF af
--    JOIN tmp_edizioni t
--      ON af.EdizioneViaggio = t.Partenza
--     AND af.ItinerarioViaggio = t.Itinerario;

-- cancellazione delle occorrenze di TramiteF copiate in TramiteP
--    DELETE tf
--    FROM TramiteF tf
--    JOIN tmp_edizioni t
--      ON tf.Partenza = t.Partenza
--     AND tf.Itinerario = t.Itinerario;

-- cancellazione delle occorrenze di AlloggioF copiate in AlloggioP
--    DELETE af
--    FROM AlloggioF af
--    JOIN tmp_edizioni t
--      ON af.EdizioneViaggio = t.Partenza
--     AND af.ItinerarioViaggio = t.Itinerario;

-- cancellazione delle occorrenze di EdizioneViaggioFutura copiate in EdizioneViaggioPassata
--    DELETE ev
--    FROM EdizioneViaggioFutura ev
--    JOIN tmp_edizioni t
--      ON ev.Partenza = t.Partenza
--     AND ev.Itinerario = t.Itinerario;

-- pulizia e deallocazione temporary table
--    DROP TEMPORARY TABLE IF EXISTS tmp_edizioni;

-- commit della transazione
--    COMMIT;

-- END$$

-- DELIMITER ;

-- CALL TestSpostaEdizioni();

-- deve essere VUOTO se lo spostamento è corretto
-- SELECT *
-- FROM EdizioneViaggioFutura
-- WHERE Rientro < CURDATE();

-- deve CONTENERE le edizioni spostate
-- SELECT *
-- FROM EdizioneViaggioPassata
-- WHERE Rientro < CURDATE();

-- NON devono esistere prenotazioni ancora legate a future già concluse
-- SELECT *
-- FROM Prenotazione
-- WHERE PartenzaF IS NOT NULL
-- AND ItinerarioF IS NOT NULL
-- AND (PartenzaF, ItinerarioF) IN (
--     SELECT Partenza, Itinerario
--     FROM EdizioneViaggioPassata
-- );

-- devono avere FK passata valorizzata e futura NULL
-- SELECT *
-- FROM Prenotazione
-- WHERE PartenzaF IS NULL
-- AND ItinerarioF IS NULL
-- AND PartenzaP IS NOT NULL;

-- TramiteF NON deve contenere edizioni concluse
-- SELECT *
-- FROM TramiteF tf
-- JOIN EdizioneViaggioPassata ev
--  ON tf.Partenza = ev.Partenza
-- AND tf.Itinerario = ev.Itinerario;

-- SELECT *
-- FROM AlloggioF af
-- JOIN EdizioneViaggioPassata ev
--   ON af.EdizioneViaggio = ev.Partenza
-- AND af.ItinerarioViaggio = ev.Itinerario;

-- SELECT
--  (SELECT COUNT(*) FROM EdizioneViaggioFutura) AS future,
--  (SELECT COUNT(*) FROM EdizioneViaggioPassata) AS past;
