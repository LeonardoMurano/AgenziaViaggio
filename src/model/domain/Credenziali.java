package model.domain;

public class Credenziali {


    //attributi classe Utente
    private String username;
    private String password;
    private Ruolo ruolo;


    //costruttore per la creazione di nuovi oggetti 'Utente' in fase di login
    public Credenziali(String username,
                       String password,
                       Ruolo ruolo) {
        this.username = username;
        this.password = password;
        this.ruolo = ruolo;
    }


    public String getUsername() {return username;}
    public String getPassword() {return password;}
    public Ruolo getRuolo() {return ruolo;}
}
