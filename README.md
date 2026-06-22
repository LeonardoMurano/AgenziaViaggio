# 🌍BASE DI DATI PER UN'AGENZIA DI VIAGGIO
## 🧳FUNZIONALITA'
Il software è il risultato del progetto universitario per l'esame Basi di dati dell'anno accademico 2025/26.

Il risultato è un **database per un'agenzia di viaggio di dimensioni medie che mette a disposizione operazioni che consentono di manipolare le strutture dati del DB** a proprio piacimento, garantendo che le modifiche apportate lascino i dati in uno stato consistente.

In particolare, viene offerto un meccanismo di autenticazione tramite credenziali `(username; password)`, da effettuare ad ogni avvio del software. Questo meccanismo consente l'autenticazione con due livelli di permessi diversi: *Cliente* o *Agente*.

I permessi che ogni utente possiede sono direttamente associati alle sue credenziali: in questo modo, **il software è utilizzabile sia da parte degli agenti che da parte dei clienti**, ognuno con a disposizione diversi permessi coerenti al proprio ruolo.

Di seguito sono riportate le funzionalità messe a disposizione rispettivamente per *Agenti* e *Clienti*:

|funzionalità offerta|utilizzabile da|
|-------|-------|
|Registrazione nuovo itinerario|Agente|
|Registrazione nuova edizione di viaggio|Agente|
|Inserimento nuovo albergo nel sistema|Agente|
|Inserimento nuovo autobus nel sistema|Agente|
|Associazione autobus-edizione di viaggio|Agente|
|Associazione albergo-tappa di un'edizione di viaggio|Agente|
|Report edizione di viaggio terminata|Agente|
|Prenotazione ad un'edizione di viaggio|Cliente|
|Cancellazione di una prenotazione|Cliente|

Informazioni dettagliate sulle operazioni offerte e sui vincoli imposti per garantire la coerenza tra i dati sono riportate nella documentazione, accessibile tramite il link presente in fondo al documento.
## 📍WORKFLOW
La realizzazione del software è stata preceduta da un'attenta fase di progettazione, al fine di ottenere un sistema il più possibile completo, efficiente ed affidabile.

Nel dettaglio, il software è stato realizzato nei seguenti steps:
1. Elicitazione e analisi dei requisiti
2. Progettazione concettuale
3. Progettazione logica
4. Progettazione fisica
5. Implementazione software (*thin client Java* + *DB sql*)

Tutte le fasi di progettazione brevemente accennate, sono approfondite e spiegate nel dettaglio nella documentazione, accessibile tramite il link presente in fondo al documento.
## ⚙️GUIDA ALL'UTILIZZO DEL SOFTWARE
### 📊Configurazione del server
Per utilizzare il software è necessario avere installato sul proprio computer il server `MySQL 8.0.46` ed aver impostato come porta utilizzata da tale servizio `3306`.

Il software è utilizzabile anche su altre tipologie di server (ma non viene garantito che tutte le operazioni risultino essere compatibili): in tal caso, per poter utilizzare il software è necessario modificare l'URL del server a cui connettersi:
1. Aprire il package `AgenziaViaggio->Resources` ed il file `db.properties` presente al suo interno.
2. Sostituire il valore associato alla proprietà `CONNECTION_URL` con l'url del proprio server.
```properties
CONNECTION_URL=[insert_url]
```
A questo punto, il software è configurato e pronto ad essere utilizzato sul proprio server.
### 🔐Istanziazione database
Dopo aver configurato il server utilizzato, è necessario istanziare il database sul proprio server. Per fare ciò è necessario:
1. Aprire il package `AgenziaViaggio` ed il file `schema.sql` presente al suo interno.
2. Mandare in esecuzione il file `schema.sql` sul proprio server: se non vengono riscontrati errori l'istanziazione è andata a buon fine, se vengono riscontrati errori è necessario verificare la compatibilità del file `schema.sql` con il proprio server utilizzato.

In fondo al file `schema.sql` sono pre-inseriti dati di testing: è possibile (e consigliato) modificare quest'ultimi in base alle proprie esigenze, sostituendo alle ennuple di test, i record inerenti la propria agenzia di viaggio:
- la terna `(username; password; ruolo)` di ogni nuovo utente registrato al sistema, deve essere obbligatoriamente inserita tramite modifica del file `schema.sql`, così come anche le varie città in cui possono svolgersi le tappe degli itinerari.
- tutte le altre informazioni, invece, possono essere inserite anche direttamente utilizzando il software:per tale ragione, si consiglia di eliminare del tutto i dati pre-inseriti inerenti tali tabelle, per evitare l'involontaria violazione di vincoli di integrità dei dati.

Infine, si tenga a mente, che se si utilizzano server `MySQL 8.0.46`, per modificare i dati pre-inseriti è necessario rieseguire sul server il file `schema.sql`, con conseguente perdita di tutte le informazioni inserite tramite utilizzo del software: è quindi consigliato modificare i dati pre-inseriti solo quando strettamente necessario ed assicurarsi di avere un backup dello stato corrente del DB prima di effettuare tale operazione; in seguito a quest'ultima sarà necessario effettuare un merge delle informazioni pre-inserite in `schema.sql` con quelle inserite dagli utenti che utilizzando il software.
### ✈️Esecuzione del software
Dopo aver configurato il server utilizzato ed aver istanziato il database, è possibile iniziare ad utilizzare il proprio database:
1. Aprire il package `AgenziaViaggio->src->main` da un ide Java.
2. Eseguire la funzione main.
Se si presentano problemi, ricontrollare che `CONNECTION_URL` sia configurato correttamente e verificare che `schema.sql` sia stato eseguito correttamente sul proprio server.
## 🗺️DOCUMENTAZIONE COMPLETA
La documentazione completa del progetto è disponibile in formato pdf al seguente link:

[Documentazione base di dati per un'agenzia di viaggio](https://uniroma2-my.sharepoint.com/:b:/g/personal/leonardo_murano_students_uniroma2_eu/IQBuWonU6XcrRKwVK8YNXk4oAdX8YOvb0bWvsx0CDE9CnUo?e=9NEz6i)
