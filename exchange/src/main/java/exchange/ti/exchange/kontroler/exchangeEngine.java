package exchange.ti.exchange.kontroler;
import exchange.ti.exchange.model.Database;

import exchange.ti.exchange.model.Database;
import exchange.ti.exchange.model.DatabaseFavCurrency;
import exchange.ti.exchange.model.DatabaseUser;
import exchange.ti.exchange.narzedzia;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@WebServlet(name = "index", value = "/")
public class exchangeEngine extends HttpServlet {


        private Database baza;

        public void init(){

            ServletContext aplikacja = getServletContext();
            baza = new Database(aplikacja);


        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            response.sendError(404, "Nieprawidłowe wywołanie");


        }
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            response.setContentType("text/html");
            response.setCharacterEncoding("utf-8");
            request.setCharacterEncoding("utf-8");
            PrintWriter out = response.getWriter();
            ServletContext aplikacja = getServletContext();


            String strona = request.getParameter("strona");
            strona = narzedzia.parsujStrone(strona, "admin");

            HttpSession sesja = request.getSession();

            String akcja = request.getParameter("akcja");
            DatabaseUser uzytkownik = (DatabaseUser) sesja.getAttribute("uzytkownik");
//            List<DatabaseFavCurrency> favCurrency = (LinedList<DatabaseFavCurrency>) sesja.getAttribute("favCurrency");

            List<String> currency = (LinkedList<String>) sesja.getAttribute("currency");

            if (uzytkownik == null){

                uzytkownik = new DatabaseUser();
                sesja.setAttribute("uzytkownik", uzytkownik);

            }

            if (currency == null){
                currency = new LinkedList<String>();
                sesja.setAttribute("currency", currency);
            }


            if(akcja == null) akcja="";

            String komunikat = "Niepoprawny login lub haslo";

            switch(akcja){

                case "zaloguj":

                    String login = request.getParameter("login");
                    String haslo = request.getParameter("haslo");
                    if (login == null) login="";
                    if (haslo == null) haslo="";

                    if((login.equals(baza.wybierzUzytkownika(login).getLogin())) && (haslo.equals(baza.wybierzUzytkownika(login).getHaslo())) && (baza.wybierzUzytkownika(login).isActive()==true)){
                        uzytkownik.setLogin(baza.wybierzUzytkownika(login).getLogin());
                        request.getSession().setAttribute("uzytkownik", baza.wybierzUzytkownika(login));
                        sesja.setAttribute("currency", baza.wybierzFavCurrency(login));
//                        System.out.println(request.getSession().getAttribute("currency"));
//                        LinkedList<DatabaseFavCurrency> lista = new LinkedList<DatabaseFavCurrency>();
//                        lista = baza.wybierzFavCurrency(login);
//                        sesja.setAttribute("currency", lista);
                        komunikat = "Zostales zalogowany jako <b>"+login+"</b>";
                    }

                    else if(baza.wybierzUzytkownika(login).isActive()==false){

                        komunikat = "Twoje konto zostalo zablokowane. Skontaktuj się z administratorem";

                    }

                    break;


                case "dodajUlub":

                    login = uzytkownik.getLogin();
                    int userId = uzytkownik.getId();
                    int idwaluty = Integer.parseInt(request.getParameter("walUlub"));
                    System.out.println(idwaluty);

                    baza.wstawUlubWalute(userId, idwaluty);

                    komunikat = "Wstawiono walute";

                    break;

                case "wyloguj":

                    uzytkownik = new DatabaseUser();
                    sesja.setAttribute("uzytkownik", uzytkownik);
                    komunikat = "Zostales wylogowany";
                    break;

                case "rejestruj":

                    uzytkownik = new DatabaseUser();

                    login = request.getParameter("login");
                    haslo = request.getParameter("haslo");
                    String haslo2 = request.getParameter("haslo2");
                    String fName = request.getParameter("fName");
                    String lName = request.getParameter("lName");
                    if (login == null) login="";
                    if (haslo == null) haslo="";
                    if (fName == null) fName="";
                    if (lName == null) lName="";

                    if((login!="") && (haslo.equals(haslo2))){

                        uzytkownik.setLogin(login);
                        uzytkownik.setHaslo(haslo);
                        uzytkownik.setImie(fName);
                        uzytkownik.setNazwisko(lName);


                        baza.wstawUzytkownika(uzytkownik);

                        komunikat = "Zostałeś zarejestrowany, aby przejść do okna logowania kliknij link poniżej";

                        break;
                    }

                    else{
                        komunikat = "Nieprawidłowe dane - login nie może byc pusty a hasła muszą się pokrywać";
                        break;
                    }


                case "waluty":

                    int waluta1 = Integer.parseInt(request.getParameter("waluta1"));
                    int waluta2 = Integer.parseInt(request.getParameter("waluta2"));

                    komunikat = "Poprawnie pobrano dane!";

//

                    break;

                case "zablokuj":

                    String zablokujLog = request.getParameter("zablokujLog");
                    int zablokujid = Integer.parseInt(request.getParameter("zablokujLog"));
                    String opcja = request.getParameter("opcja");
                    if(zablokujLog==null) zablokujLog="";

                     boolean f = baza.zablokujUsera(zablokujid, opcja);

                     if((f==true) && (opcja.equals("zablokuj"))){

                         komunikat = "Zablokowano usera";

                     }
                    else if((f==true) && (opcja.equals("odblokuj"))){

                        komunikat = "Odblokowano usera";

                    }

                     else{

                         komunikat = "User nie istnieje";
                     }


                    break;

                case "nkurs":

                    int idwaluty1 = Integer.parseInt(request.getParameter("waluta3"));
                    int idwaluty2 = Integer.parseInt(request.getParameter("waluta4"));
                    double kurs1 = Double.parseDouble(request.getParameter("kurs"));
                    System.out.println(kurs1);

                    String data = request.getParameter("data");

                    baza.wstawKurs(idwaluty1, idwaluty2,kurs1,data);

                    komunikat = "Wstawiono nowy kurs ";

                    break;

                case "uprawnienia":

                    int uprawnienia = Integer.parseInt(request.getParameter("wart"));
                    int id = Integer.parseInt(request.getParameter("permission"));
                    if(uprawnienia==0 || uprawnienia==1 || uprawnienia==2){

                        baza.zmienUprawnienia(id, uprawnienia);
                        komunikat = "Zmieniono uprawnienia";
                    }

                    else{

                        komunikat = "Błedne wywołanie !";
                    }


                    break;

                case "ustawienia":

                    String imie = request.getParameter("imie");
                    String nazwisko = request.getParameter("nazwisko");
                    if(imie==null) imie="";
                    if(nazwisko==null) nazwisko="";

                    int wiek = narzedzia.parsujInteger(request.getParameter("wiek"), -1);

                    String kolorTla = request.getParameter("kolortla");
                    if(kolorTla==null) kolorTla ="#FFFFFF";

                    uzytkownik.setImie(imie);
                    uzytkownik.setNazwisko(nazwisko);

                    sesja.setAttribute("uzytkownik", uzytkownik);
                    komunikat = "Ustawienia zostaly prawidlowo zapisane";

                    break;

                default:
                    komunikat = "Nieprawidlowe wywolania";
                    break;
            }

                String szablon = narzedzia.pobierzSzablon("komunikat.jsp", aplikacja);
                szablon = szablon.replace("[[KOMUNIKAT]]", komunikat);
                out.println(szablon);
                out.close();

        }
    }
