

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
    CONSTRAINT `fk_EdizioneViaggioPassata_Itinerario10`
    FOREIGN KEY (`Itinerario`)
    REFERENCES `AgenziaViaggio`.`Itinerario` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_EdizioneViaggioPassata_Itinerario1_idx` ON `AgenziaViaggio`.`EdizioneViaggioFutura` (`Itinerario` ASC) VISIBLE;


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
    ON UPDATE NO ACTION)
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
    PRIMARY KEY (`IDmezzo`))
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
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_TappaNotturna_Itinerario1_idx` ON `AgenziaViaggio`.`TappaNotturna` (`Itinerario` ASC) VISIBLE;

CREATE INDEX `fk_TappaNotturna_Citta1_idx` ON `AgenziaViaggio`.`TappaNotturna` (`Citta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgenziaViaggio`.`Albergo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AgenziaViaggio`.`Albergo` (
    `NomeAlbergo` VARCHAR(100) NOT NULL,
    `Referente` VARCHAR(100) NOT NULL,
    `CostoNotteOspite` DECIMAL(10,2) NOT NULL,
    `NumeroMassimoOspiti` INT NOT NULL,
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
    ON UPDATE NO ACTION)
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
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE INDEX `fk_AlloggioP_TappaNotturna1_idx` ON `AgenziaViaggio`.`AlloggioP` (`TappaNotturna` ASC, `ItinerarioTappa` ASC) VISIBLE;

CREATE INDEX `fk_AlloggioP_Albergo1_idx` ON `AgenziaViaggio`.`AlloggioP` (`NomeAlbergo` ASC, `Citta` ASC) INVISIBLE;

CREATE INDEX `report_alloggioP` ON `AgenziaViaggio`.`AlloggioP` (`EdizioneViaggio` ASC, `ItinerarioViaggio` ASC) VISIBLE;


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
    ON UPDATE NO ACTION)
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

END$$

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

    -- verifica che il numero di ospiti sia >=0
    IF p_numeroOspiti <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Numero ospiti non valido';
    END IF;

    -- implementazione regola aziendale:
    -- verifica che la prenotazione sia inerente un viaggio con partenza prevista tra >=20 giorni
    IF DATEDIFF(p_partenzaF, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Prenotazione non consentita: meno di 20 giorni alla partenza';
    END IF;


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
    -- LAST_INSERT_ID() è specifico della connessione corrente: non è necessario implementare una transazione
    SET p_idPrenotazione = LAST_INSERT_ID();

END$$

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

    -- se la successiva SELECT non trova righe forza v_cliente = NULL rendendo i successivi controlli affidabili
    -- necessario in quanto il comportamento di MySQL in seguito ad evento NOT FOUND è imprevedibile
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET v_cliente = NULL;

    -- recupera i dati della prenotazione in base ad p_idPrenotazione
    SELECT InfoCliente, PartenzaF
    INTO v_cliente, v_partenza
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

    -- implementazione regola aziendale:
    -- verifica che la prenotazione sia inerente un viaggio con partenza prevista tra >=20 giorni
    IF DATEDIFF(v_partenza, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Cancellazione non consentita: meno di 20 giorni alla partenza';
    END IF;

    -- cancellazione della prenotazione identificata da p_idPrenotazione
    DELETE FROM Prenotazione
    WHERE IDprenotazione = p_idPrenotazione;

END$$

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

END$$

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

    -- verifica che la data della partenza sia tra >=20 giorni:
    -- vincolo che è diretta conseguenza della regola aziendale secondo la quale
    -- è possibile effettuare prenotazioni quando mancano >=20 giorni alla partenza
    IF DATEDIFF(p_dataPartenza, CURRENT_DATE()) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La data di partenza deve essere almeno 20 giorni successiva alla data odierna';
    END IF;

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
                           ('GrandTourItalia', 2000);

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
                                      ('2026-07-01','2026-07-10',0,5000,'ItaliaNord'),
                                      ('2026-07-05','2026-07-12',0,4800,'ItaliaSud'),
                                      ('2026-07-10','2026-07-18',0,4200,'ArteToscana'),
                                      ('2026-07-15','2026-07-22',0,4000,'LaghiNord'),
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

INSERT INTO EdizioneViaggioPassata VALUES
                                       ('2025-01-01','2025-01-10',40,5000,'ItaliaNord'),
                                       ('2025-01-05','2025-01-12',35,4800,'ItaliaSud'),
                                       ('2025-01-10','2025-01-18',30,4200,'ArteToscana'),
                                       ('2025-01-15','2025-01-22',45,4000,'LaghiNord'),
                                       ('2025-01-20','2025-01-28',38,3800,'CittaVenete'),
                                       ('2025-02-01','2025-02-10',50,6000,'SiciliaTour'),
                                       ('2025-02-05','2025-02-12',25,3000,'RomaClassica'),
                                       ('2025-02-10','2025-02-18',42,4500,'Costiera'),
                                       ('2025-02-15','2025-02-22',28,3500,'FoodTour'),
                                       ('2025-02-20','2025-02-28',33,4200,'MareAdriatico'),
                                       ('2025-03-01','2025-03-10',31,4200,'MareTirreno'),
                                       ('2025-03-05','2025-03-15',55,7000,'Dolomiti'),
                                       ('2025-03-10','2025-03-18',47,5500,'PugliaTour'),
                                       ('2025-03-15','2025-03-22',39,4000,'EmiliaRomagna'),
                                       ('2025-03-20','2025-03-30',60,9000,'GrandTourItalia');

INSERT INTO TappaNotturna VALUES
                              (1,2,'ItaliaNord','Milano'),
                              (2,2,'ItaliaNord','Torino'),
                              (1,1,'ItaliaSud','Napoli'),
                              (1,1,'ArteToscana','Firenze'),
                              (1,1,'LaghiNord','Verona'),
                              (1,1,'CittaVenete','Venezia'),
                              (1,1,'SiciliaTour','Palermo'),
                              (1,1,'RomaClassica','Roma'),
                              (1,1,'Costiera','Napoli'),
                              (1,1,'FoodTour','Parma'),
                              (1,1,'MareAdriatico','Bari'),
                              (1,1,'MareTirreno','Genova'),
                              (1,1,'Dolomiti','Verona'),
                              (1,1,'PugliaTour','Lecce'),
                              (1,1,'EmiliaRomagna','Bologna');

INSERT INTO Albergo VALUES
                        ('Hotel Milano','Marco',100,100,'Via Roma 1','111','111','milano@h.it','Milano'),
                        ('Hotel Torino','Marco',90,80,'Via Torino 1','222','222','torino@h.it','Torino'),
                        ('Hotel Napoli','Marco',80,90,'Via Napoli 1','333','333','napoli@h.it','Napoli'),
                        ('Hotel Firenze','Marco',120,70,'Via Firenze 1','444','444','firenze@h.it','Firenze'),
                        ('Hotel Venezia','Marco',150,60,'Via Venezia 1','555','555','venezia@h.it','Venezia'),
                        ('Hotel Palermo','Marco',110,85,'Via Palermo 1','666','666','palermo@h.it','Palermo'),
                        ('Hotel Roma','Marco',130,120,'Via Roma 2','777','777','roma@h.it','Roma'),
                        ('Hotel Bari','Marco',95,75,'Via Bari 1','888','888','bari@h.it','Bari'),
                        ('Hotel Lecce','Marco',85,60,'Via Lecce 1','999','999','lecce@h.it','Lecce'),
                        ('Hotel Parma','Marco',90,65,'Via Parma 1','101','101','parma@h.it','Parma'),
                        ('Hotel Bologna','Marco',100,80,'Via Bologna 1','102','102','bologna@h.it','Bologna'),
                        ('Hotel Verona','Marco',110,70,'Via Verona 1','103','103','verona@h.it','Verona'),
                        ('Hotel Pisa','Marco',95,60,'Via Pisa 1','104','104','pisa@h.it','Pisa'),
                        ('Hotel Genova','Marco',120,90,'Via Genova 1','105','105','genova@h.it','Genova'),
                        ('Hotel Siena','Marco',115,75,'Via Siena 1','106','106','siena@h.it','Siena');

INSERT INTO Prenotazione (NumeroOspitiPrenotazione, InfoCliente, PartenzaP, ItinerarioP)
VALUES
    (2,'mrossi','2025-01-01','ItaliaNord'),
    (3,'lbianchi','2025-01-05','ItaliaSud'),
    (1,'gverdi','2025-01-10','ArteToscana'),
    (4,'fneri','2025-01-15','LaghiNord'),
    (2,'dconti','2025-01-20','CittaVenete'),
    (5,'srosa','2025-02-01','SiciliaTour'),
    (2,'vverdi','2025-02-05','RomaClassica'),
    (3,'tneri','2025-02-10','Costiera'),
    (2,'mrossi','2025-02-15','FoodTour'),
    (1,'lbianchi','2025-02-20','MareAdriatico'),
    (2,'gverdi','2025-03-01','MareTirreno'),
    (4,'fneri','2025-03-05','Dolomiti'),
    (3,'dconti','2025-03-10','PugliaTour'),
    (2,'srosa','2025-03-15','EmiliaRomagna'),
    (5,'vverdi','2025-03-20','GrandTourItalia');

INSERT INTO TramiteP VALUES
                         ('2025-01-01','ItaliaNord',1),
                         ('2025-01-05','ItaliaSud',2),
                         ('2025-01-10','ArteToscana',3),
                         ('2025-01-15','LaghiNord',4),
                         ('2025-01-20','CittaVenete',5),
                         ('2025-02-01','SiciliaTour',6),
                         ('2025-02-05','RomaClassica',7),
                         ('2025-02-10','Costiera',8),
                         ('2025-02-15','FoodTour',9),
                         ('2025-02-20','MareAdriatico',10),
                         ('2025-03-01','MareTirreno',11),
                         ('2025-03-05','Dolomiti',12),
                         ('2025-03-10','PugliaTour',13),
                         ('2025-03-15','EmiliaRomagna',14),
                         ('2025-03-20','GrandTourItalia',15);

INSERT INTO TramiteF VALUES
                         ('2026-07-01','ItaliaNord',1),
                         ('2026-07-05','ItaliaSud',2),
                         ('2026-07-10','ArteToscana',3),
                         ('2026-07-15','LaghiNord',4),
                         ('2026-07-20','CittaVenete',5),
                         ('2026-08-01','SiciliaTour',6),
                         ('2026-08-05','RomaClassica',7),
                         ('2026-08-10','Costiera',8),
                         ('2026-08-15','FoodTour',9),
                         ('2026-08-20','MareAdriatico',10),
                         ('2026-09-01','MareTirreno',11),
                         ('2026-09-05','Dolomiti',12),
                         ('2026-09-10','PugliaTour',13),
                         ('2026-09-15','EmiliaRomagna',14),
                         ('2026-09-20','GrandTourItalia',15);

INSERT INTO AlloggioP VALUES
                          ('2025-01-01','ItaliaNord',1,'ItaliaNord','Hotel Milano','Milano'),
                          ('2025-01-01','ItaliaNord',2,'ItaliaNord','Hotel Torino','Torino'),
                          ('2025-01-05','ItaliaSud',1,'ItaliaSud','Hotel Napoli','Napoli'),
                          ('2025-01-10','ArteToscana',1,'ArteToscana','Hotel Firenze','Firenze'),
                          ('2025-01-15','LaghiNord',1,'LaghiNord','Hotel Verona','Verona'),
                          ('2025-01-20','CittaVenete',1,'CittaVenete','Hotel Venezia','Venezia'),
                          ('2025-02-01','SiciliaTour',1,'SiciliaTour','Hotel Palermo','Palermo'),
                          ('2025-02-05','RomaClassica',1,'RomaClassica','Hotel Roma','Roma'),
                          ('2025-02-10','Costiera',1,'Costiera','Hotel Napoli','Napoli'),
                          ('2025-02-15','FoodTour',1,'FoodTour','Hotel Parma','Parma'),
                          ('2025-02-20','MareAdriatico',1,'MareAdriatico','Hotel Bari','Bari'),
                          ('2025-03-01','MareTirreno',1,'MareTirreno','Hotel Genova','Genova'),
                          ('2025-03-05','Dolomiti',1,'Dolomiti','Hotel Verona','Verona'),
                          ('2025-03-10','PugliaTour',1,'PugliaTour','Hotel Lecce','Lecce'),
                          ('2025-03-15','EmiliaRomagna',1,'EmiliaRomagna','Hotel Bologna','Bologna');

INSERT INTO AlloggioF VALUES
                          ('2026-07-01','ItaliaNord',1,'ItaliaNord','Hotel Milano','Milano'),
                          ('2026-07-01','ItaliaNord',2,'ItaliaNord','Hotel Torino','Torino'),
                          ('2026-07-05','ItaliaSud',1,'ItaliaSud','Hotel Napoli','Napoli'),
                          ('2026-07-10','ArteToscana',1,'ArteToscana','Hotel Firenze','Firenze'),
                          ('2026-07-15','LaghiNord',1,'LaghiNord','Hotel Verona','Verona'),
                          ('2026-07-20','CittaVenete',1,'CittaVenete','Hotel Venezia','Venezia'),
                          ('2026-08-01','SiciliaTour',1,'SiciliaTour','Hotel Palermo','Palermo'),
                          ('2026-08-05','RomaClassica',1,'RomaClassica','Hotel Roma','Roma'),
                          ('2026-08-10','Costiera',1,'Costiera','Hotel Napoli','Napoli'),
                          ('2026-08-15','FoodTour',1,'FoodTour','Hotel Parma','Parma'),
                          ('2026-08-20','MareAdriatico',1,'MareAdriatico','Hotel Bari','Bari'),
                          ('2026-09-01','MareTirreno',1,'MareTirreno','Hotel Genova','Genova'),
                          ('2026-09-05','Dolomiti',1,'Dolomiti','Hotel Verona','Verona'),
                          ('2026-09-10','PugliaTour',1,'PugliaTour','Hotel Lecce','Lecce'),
                          ('2026-09-15','EmiliaRomagna',1,'EmiliaRomagna','Hotel Bologna','Bologna');