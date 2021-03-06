<%@ page isELIgnored="false" %>
<%@ page import="exchange.ti.exchange.model.DatabaseUser,exchange.ti.exchange.model.DatabaseFavCurrency,exchange.ti.exchange.model.Database" %>
<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="uzytkownik" class="exchange.ti.exchange.model.DatabaseUser" scope="session"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style><%@include file="/WEB-INF/css/style.css"%></style>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="text/javascript" src="slider.jsp"></script>
    <script type="text/javascript" src="scrollAnimated.jsp"></script>


    <title>Ex</title>
</head>
<body onload="changeSlideView()">

<div class="container-fluid p-0 m-0">

    <div class="row p-0 m-0">   <!-- 6vh -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top border-bottom border-secondary">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand font-weight-bold" href="#">EX
                <img src="logo.png" width="30" height="30" alt="">
            </a>

            <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                <ul class="navbar-nav mr-auto ml-auto mt-2 mt-lg-0">
                    <li class="nav-item font-weight-bold">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link font-weight-bold" href="#secondPage">Exchange Rate</a>
                    </li>
                    <li class="nav-item font-weight-bold">
                        <a class="nav-link" href="#goto">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link font-weight-bold" href="#goto">About Us</a>
                    </li>
                    <%if (uzytkownik.getUprawnienia()==2){%>
                        <li class="nav-item">
                            <a class="nav-link font-weight-bold" href="./admin.jsp">Administracja</a>
                        </li>
                    <%}%>
                </ul>
                <% if (uzytkownik.getUprawnienia()<0){ %>
                <ul class="navbar-nav mr-3 mt-2 mt-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" type="button" data-toggle="modal" data-target="#logIn">Log In</a>
                    </li>
                </ul>
                <button class="btn btn-outline-success my-2 my-sm-0" data-target="#register" type="button" data-toggle="modal">Register now !</button>
                <%} else {%>

                <form action="index?akcja=wyloguj" method="post">
                    <input type="submit" value="Wyloguj" /></br>
                </form>

                <%}%>


            </div>
        </nav>
    </div>

    <div class="row p-0 m-0">

        <div id="firstPage">

            <div id="firstContentPanel" class="hello col-md-4 ml-md-5 mobile-parallax d-none d-md-block">

                <div class="slides">
                    <h3>How war in Ukraine will affect currency worldwide ? </h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>
                    <p class="source">see New York Times arcticle <a href="">here</a></p>
                </div>

                <div class="slides">
                    <h3>Polish zloty is goin' down</h3>
                    <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance.</p>
                    <p class="source">see CNN article <a href="">here</a></p>
                </div>

                <div class="slides">
                    <h3>Example header1</h3>
                    <p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable.</p>
                    <p class="source">see article <a href="">here</a></p>
                </div>

                <div class="slides">
                    <h3>Example header2 </h3>
                    <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.</p>
                    <p class="source">see article <a href="">here</a></p>
                </div>

            </div>

            <div id="secondContentPanel" class="hello col-md-6 offset-md-5 mobile-parallax">

                <ul class="list-group">
    <%
        try {
            Class.forName("org.sqlite.JDBC");
            String url="jdbc:sqlite:C:\\Users\\Adam\\IdeaProjects\\exchange\\target\\exchange-1.0-SNAPSHOT\\WEB-INF\\Database.sqlite";

            Connection polaczenie;
            Statement stat;

            polaczenie = DriverManager.getConnection(url);
            stat = polaczenie.createStatement();

            ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                    "SELECT nazwa, kurs FROM favCurrency LEFT JOIN waluty w on favCurrency.currencyId = w.id LEFT JOIN kursy k on w.id = k.idWaluty2 LEFT JOIN uzytkownicy u on favCurrency.userId = u.id WHERE u.login='"+uzytkownik.getLogin()+"'");

            //przerobic dodajac subquery
            while(wynik1.next()){
                String nazwa = wynik1.getString("nazwa");
                String kurs = wynik1.getString("kurs");
                out.println("<li class=\"list-group-item my-2\">"+nazwa+" - ");
                out.println(kurs+"</li>");
            }
            stat.close();
        }
        catch(Exception e)
        {
            System.out.println("Could not connect");
        }
    %>
                </ul>
            </div>
        </div>
    </div>

    <div class="row p-0 m-0">

        <div id="secondPage" class="col-12">

            <div id="walutyForm" class="container-fluid">

            <form action="./result.jsp" target="_blank" method="post">

                <label class="mx-2" for="w1">Wybierz walute: </label>
                <select id="w1" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="waluta1">
                    <%
                        try {
                            Class.forName("org.sqlite.JDBC");
                            String url="jdbc:sqlite:C:\\Users\\Adam\\IdeaProjects\\exchange\\target\\exchange-1.0-SNAPSHOT\\WEB-INF\\Database.sqlite";

                            Connection polaczenie;
                            Statement stat;

                            polaczenie = DriverManager.getConnection(url);
                            stat = polaczenie.createStatement();

                            ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                                    "SELECT * FROM waluty");
                            while(wynik1.next()){
                                int id = wynik1.getInt("id");
                                String nazwa = wynik1.getString("nazwa");
                                out.println("<option value="+id+">"+nazwa+"</option>");
                            }

                            stat.close();
                        }
                        catch(Exception e)
                        {
                            System.out.println("Could not connect");
                        }


                    %>

                </select>

                <label class="mx-2" for="w2">Wybierz walute: </label>
                <select id="w2" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="waluta2">
                    <%
                        try {
                            Class.forName("org.sqlite.JDBC");
                            String url="jdbc:sqlite:C:\\Users\\Adam\\IdeaProjects\\exchange\\target\\exchange-1.0-SNAPSHOT\\WEB-INF\\Database.sqlite";

                            Connection polaczenie;
                            Statement stat;

                            polaczenie = DriverManager.getConnection(url);
                            stat = polaczenie.createStatement();

                            ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                                    "SELECT * FROM waluty");
                            while(wynik1.next()){
                                int id = wynik1.getInt("id");
                                String nazwa = wynik1.getString("nazwa");
                                out.println("<option value="+id+">"+nazwa+"</option>");
                            }

                            stat.close();
                        }
                        catch(Exception e)
                        {
                            System.out.println("Could not connect");
                        }


                    %>
                </select>

                <br>
                    <input class="btn btn-success my-2 mr-2" type="submit" value="Zatwierd??">

            </form>

                <div class="container-fluid">

                    <jsp:include page="/WEB-INF/widok/QueryResult.jsp"/>

                </div>

                <h1 class="header mt-5">Lub</h1>

            </div>
        </div>

    </div>


    <div class="row p-0 m-0">

        <! Modal login !>

        <div class="modal fade" id="logIn" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="modal-content animate" action="index?akcja=zaloguj" method="post">

                            <div class="container">


                                    Login: <input type="text" class="my-2" placeholder="Enter Username" name="login" required/><br>
                                    Haslo: <input type="password" class="my-2" placeholder="Enter Password" name="haslo" required></br>
                                    <input class="btn btn-success my-2 mr-2" type="submit" value="Zaloguj">



                                <label>
                                    <input type="checkbox" checked="checked" name="remember"> Remember me
                                </label>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="register" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="modal-content animate" action="index?akcja=rejestruj" method="post">

                            <div class="container">

                                <input type="text" class="my-2" placeholder="Enter Username" name="login" required/><br>
                                <input type="password" class="my-2" placeholder="Enter Password" name="haslo" required></br>
                                <input type="password" class="my-2" placeholder="Enter Password again" name="haslo2" required></br>
                                <input type="text" class="my-2" placeholder="First Name" name="fName"/><br>
                                <input type="text" class="my-2" placeholder="Last Name" name="lName"/><br>

                                <input class="btn btn-success my-2 mr-2" type="submit" value="Register">

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>




        <div id="goto" class="footer col-12">

            <div class="row p-0 m-0">
                <div class="aboutUs col-md-8 my-5">

                    <p>This static currency converter provides the European Commission???s official monthly accounting rate and the conversion rates as established by the Accounting Officer of the European Commission in line with article 19 of the Financial Regulation.

                        These rates are used to calculate amounts for the reimbursement of expenses, travel or subsistence costs for external people participating in meetings, interviews etc. at the request of the European Commission.

                        The converter also allows general users to get monthly currency conversion rates.

                        The rates indicated are the market rates for the second to last day of the previous month as quoted by the European Central Bank or, depending on availability, provided by the delegations or other appropriate sources close to that date.

                        Exchange provides rates for current and old currencies for countries both inside and outside the European Union. For each currency, the converter provides the historic rates of conversion. These exchange rates are available in electronic format in the form of downloadable files.

                        This information on this page is strictly informative in nature and does not give users any rights.</p>

                </div>

                <div class="contactUs col-md-4 my-5">

                    <p class="my-0 py-0">Lea 43/21 31-216 Krak??w - Poland</p>
                    <p class="my-0 py-0">exchange@exchange.com</p>
                    <p class="my-0 py-0">+48 678 564 674</p>

                </div>
            </div>



            <h6 class="col-12 mt-3">All rights reserved 2022 @ Kozie?? | Gamo?? | M??l | Wojak </h6>
        </div>

    </div>

</div>
</body>
</html>