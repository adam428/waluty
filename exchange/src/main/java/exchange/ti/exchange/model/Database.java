package exchange.ti.exchange.model;

import javax.servlet.ServletContext;
import javax.xml.crypto.Data;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Database {

    public static final String DRIVER = "org.sqlite.JDBC";
    public static final String DB = "Database.sqlite";

    private Connection polaczenie;
    private Statement stat;

    public Database() {
    }

    public Database(ServletContext context) {

        String sciezka = context.getRealPath("WEB-INF");
        try {
            Class.forName(DRIVER);
            System.out.println(sciezka);
        } catch (ClassNotFoundException e) {
            System.err.println("Brak sterownika JDBC");
        }

        try {
            polaczenie = DriverManager.getConnection("jdbc:sqlite:" + sciezka + "\\" + DB);
            stat = polaczenie.createStatement();
            stworzTablice();
            stworzTabliceFavCurrency();
            stworzTabliceKursy();
            stworzTabliceWalut();
        } catch (SQLException e) {
            System.err.println("Problem z polaczeniem z baza danych");
            e.printStackTrace();
        }

    }

    public boolean stworzTablice() {

        String stworzUzytkownicy =
                "CREATE TABLE IF NOT EXISTS uzytkownicy(" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                        "login VARCHAR(64) UNIQUE," +
                        "haslo VARCHAR(64)," +
                        "uprawnienia INTEGER," +
                        "imie VARCHAR(64), " +
                        "nazwisko VARCHAR(64), " +
                        "isActive INTEGER )";


        try {
            stat.execute(stworzUzytkownicy);
            System.out.println("Utworzono tabele uzytkownicy");

        } catch (SQLException e) {
            System.err.println("Blad przy tworzeniu tebeli");
            e.printStackTrace();
            return false;
        }


        return true;

    }

    public boolean stworzTabliceWalut() {

        String stworzWaluty =
                "CREATE TABLE IF NOT EXISTS waluty(" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                        "nazwa VARCHAR(64))";

        try {
            stat.execute(stworzWaluty);
            System.out.println("Utworzono tabele waluty");

        } catch (SQLException e) {
            System.err.println("Blad przy tworzeniu tebeli waluty");
            e.printStackTrace();
            return false;
        }


        return true;

    }

    public boolean stworzTabliceFavCurrency() {

        String stworzFavCurr =
                "CREATE TABLE IF NOT EXISTS favCurrency(" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                        "userId INTEGER," +
                        "currencyId INTEGER," +
                        "FOREIGN KEY (currencyId) REFERENCES waluty(id)," +
                        "FOREIGN KEY(userId) REFERENCES uzytkownicy(id))";


        try {
            stat.execute(stworzFavCurr);
            System.out.println("Utworzono tabele ulubione waluty");

        } catch (SQLException e) {
            System.err.println("Blad przy tworzeniu tebeli ulubionych walut");
            e.printStackTrace();
            return false;
        }


        return true;

    }

    public boolean stworzTabliceKursy() {

        String stworzKursy =
                "CREATE TABLE IF NOT EXISTS kursy(" +
                        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                        "idWaluty INTEGER," +
                        "idWaluty2 INTEGER," +
                        "kurs DOUBLE," +
                        "dataKursu VARCHAR(64)," +
                        "FOREIGN KEY (idWaluty) REFERENCES waluty(id)," +
                        "FOREIGN KEY (idWaluty2) REFERENCES waluty(id))";


        try {
            stat.execute(stworzKursy);
            System.out.println("Utworzono tabele Kursy");

        } catch (SQLException e) {
            System.err.println("Blad przy tworzeniu tebeli Kursy");
            e.printStackTrace();
            return false;
        }


        return true;

    }

    public boolean wstawUzytkownika(DatabaseUser uzytkownik) {

        try {
            PreparedStatement zapytanie = polaczenie.prepareStatement(
                    "INSERT INTO uzytkownicy VALUES (NULL,?,?,?,?,?,?)"
            );
            zapytanie.setString(1, uzytkownik.getLogin());
            zapytanie.setString(2, uzytkownik.getHaslo());
            zapytanie.setInt(3, 1);
            zapytanie.setString(4, uzytkownik.getImie());
            zapytanie.setString(5, uzytkownik.getNazwisko());
            zapytanie.setInt(6, 1);

            zapytanie.execute();
            System.out.println("Wstawiono uzytkownika" + uzytkownik.getLogin());

        } catch (SQLException e) {
            System.err.println("Blad przy wstawianiu uzytkownika");
            e.printStackTrace();
            return false;
        }

        return true;
    }

//    public List<DatabaseFavCurrency>wybierzFavCurrency(String login){
//        List<DatabaseFavCurrency> records = new LinkedList<DatabaseFavCurrency>();
//
//        try{
//            ResultSet wynik = stat.executeQuery( //uwaga na SQL injection
//                    "SELECT id, nazwa FROM favCurrency LEFT JOIN uzytkownicy ON(uzytkownicy.id = favCurrency.userId) LEFT JOIN waluty ON(waluty.id = favCurrency.curencyId = waluty.id) WHERE '"+login+"'");
//
//            int id;
//            DatabaseFavCurrency record = new DatabaseFavCurrency();
//
//            while(wynik.next()){
//                id = wynik.getInt(wynik.getInt("id"));
//                record.setId(id);
//                record.setNazwa(wynik.getString("nazwa"));
//                records.add(record);
//
//            }
//
//        }catch(SQLException e){
//            System.err.println("Blad przy wybieraniu ulubionych walut");
//        }
//
//        return records;
//
//    }

    public List<String> wybierzFavCurrency(String login) {
        List<String> currency = new LinkedList<String>();


        try {
            ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                    "SELECT nazwa, kurs FROM favCurrency LEFT JOIN waluty ON (favCurrency.currencyId = waluty.id) LEFT JOIN uzytkownicy ON (favCurrency.userId = uzytkownicy.id) LEFT JOIN kursy k on waluty.id = k.idWaluty WHERE waluty.id = k.idWaluty AND  uzytkownicy.login = '" + login + "'");


            while (wynik1.next()) {
                currency.add(wynik1.getString("nazwa"));
//                String tmp = (String) wynik1.getInt("kurs");

            }

        } catch (SQLException e) {
            System.err.println("Blad przy wybieraniu ulubionych walut");
        }


        return currency;

    }


//        public List<DatabaseUser>wybierzUzytkownikow(){
//            List<DatabaseUser> uzytkownicy = new LinkedList<DatabaseUser>();
//
//            try{
//                ResultSet wynik = stat.executeQuery( //uwaga na SQL injection
//                        "SELECT * FROM uzytkownicy"
//                );
//                int id;
//                DatabaseUser uzytkownik = new DatabaseUser();
//                while(wynik.next()){
//
//                    id = wynik.getInt(wynik.getInt("id"));
//                    uzytkownik.setId(id);
//                    uzytkownik.setLogin(wynik.getString("login"));
//                    uzytkownik.setHaslo(wynik.getString("haslo"));
//                    uzytkownik.setUprawnienia(wynik.getInt("uprawnienia"));
//                    uzytkownik.setImie(wynik.getString("imie"));
//                    uzytkownik.setNazwisko(wynik.getString("nazwisko"));
//                    uzytkownik.setWiek(wynik.getInt("wiek"));
//                    uzytkownik.setKolorTla(wynik.getString("kolortla"));
//
//                    uzytkownicy.add(uzytkownik);
//
//                }
//
//            }catch(SQLException e){
//                System.err.println("Blad przy wybieraniu uzytkownikow");
//            }
//
//            return uzytkownicy;
//
//        }

    public DatabaseUser wybierzUzytkownika(String login) {

        DatabaseUser uzytkownik = new DatabaseUser();

        try {
            ResultSet wynik = stat.executeQuery( //uwaga na SQL injection
                    "SELECT * FROM uzytkownicy WHERE login = '" + login + "' LIMIT 1"
            );
            int id;
            while (wynik.next()) {
                id = wynik.getInt("id");
                uzytkownik.setId(id);
                uzytkownik.setLogin(login);
                uzytkownik.setHaslo(wynik.getString("haslo"));
                uzytkownik.setUprawnienia(wynik.getInt("uprawnienia"));
                uzytkownik.setImie(wynik.getString("imie"));
                uzytkownik.setNazwisko(wynik.getString("nazwisko"));
                uzytkownik.setActive(wynik.getBoolean("isActive"));
            }

        } catch (SQLException e) {
            System.err.println("Blad przy wybieraniu uzytkownika: " + login);
        }
        return uzytkownik;

    }

    public boolean wstawKurs(int idwaluty1, int idwaluty2, double kurs, String data){
        try {
            PreparedStatement zapytanie = polaczenie.prepareStatement(
                    "INSERT INTO kursy VALUES (NULL,?,?,?,?)"
            );
            zapytanie.setInt(1, idwaluty1);
            zapytanie.setInt(2, idwaluty2);
            zapytanie.setDouble(3, kurs);
            zapytanie.setString(4, data);

            zapytanie.execute();
            System.out.println("Wstawiono kurs");

        } catch (SQLException e) {
            System.err.println("Blad przy wstawianiu kursu");
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean customQuery(String query, int option){
        try {

            if(option==0) {
                PreparedStatement zapytanie = polaczenie.prepareStatement(
                        "INSERT INTO kursy VALUES (NULL,?,?,?,?)"
                );

                zapytanie.execute();
                System.out.println("Wykonało się");
            }
            else if(option==1){




            }
        } catch (SQLException e) {
            System.err.println("Blad");
            e.printStackTrace();
            return false;
        }

        return true;
    }


    public boolean zablokujUsera(String login, String opcja) {

        DatabaseUser uzytkownik = new DatabaseUser();

        try {

            ResultSet wynik = stat.executeQuery( //uwaga na SQL injection
                    "SELECT * FROM uzytkownicy WHERE login = '" + login + "' LIMIT 1");

            if(wynik.next()){
            while (wynik.next()) {

                uzytkownik.setLogin(login);
            }

            if(opcja.equals("zablokuj")){

                PreparedStatement zapytanie = polaczenie.prepareStatement(
                        "UPDATE uzytkownicy SET isActive='0' WHERE login= ?"
                );
                zapytanie.setString(1, login);
                zapytanie.execute();
                System.out.println("Zablokowano uzytkownika: " + login);

                return true;
            }
            if(opcja.equals("odblokuj")){

                PreparedStatement zapytanie = polaczenie.prepareStatement(
                        "UPDATE uzytkownicy SET isActive='1' WHERE login= ?"
                );
                zapytanie.setString(1, login);
                zapytanie.execute();
                System.out.println("Odblokowano uzytkownika: " + login);

                return true;
            }
            return false;
            }
            else{
                return false;
            }


        } catch (SQLException e) {
            System.err.println("Blad przy blokowaniu uzytkownika");
            e.printStackTrace();
            return false;
        }

    }
}
