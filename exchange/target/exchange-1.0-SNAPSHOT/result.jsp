<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.lang.*" import="java.sql.*"%>
<html>
<head>
    <title>Result</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style><%@include file="/WEB-INF/css/style.css"%></style>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</head>
<body>
<div id="page" class="container-fluid m-0 p-0">
    <%

        int waluta1 = Integer.parseInt(request.getParameter("waluta1"));
        int waluta2 = Integer.parseInt(request.getParameter("waluta2"));

        try {
            Class.forName("org.sqlite.JDBC");
            String url="jdbc:sqlite:C:\\Users\\Adam\\IdeaProjects\\exchange\\target\\exchange-1.0-SNAPSHOT\\WEB-INF\\Database.sqlite";

            Connection polaczenie;
            Statement stat;

            polaczenie = DriverManager.getConnection(url);
            stat = polaczenie.createStatement();

            ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                    "SELECT kurs, dataKursu FROM kursy WHERE idWaluty='"+waluta1+"' IN (SELECT id FROM waluty) AND idWaluty2='"+waluta2+"' IN (SELECT id FROM kursy)");

            out.println("<table class=\"table table-dark\">\n" +
                    "  <thead>\n" +
                    "    <tr>\n" +
                    "      <th scope=\"col\">#</th>\n" +
                    "      <th scope=\"col\">Historia kursu</th>\n" +
                    "      <th scope=\"col\">Data</th>\n" +
                    "    </tr>\n" +
                    "  </thead>\n" +
                    "  <tbody>\n");

            while(wynik1.next()){
                int i = 1;
                Double kurs = wynik1.getDouble("kurs");
                String dataKursu = wynik1.getString("dataKursu");


                out.println("<tr><th scope=\"row\">"+i+"</th>\n");
                out.println("<th scope=\"row\">"+kurs+"</th>\n");
                out.println("<th scope=\"row\">"+dataKursu+"</th>\n");
                i++;

            }
            out.println("</tr></tbody></table>");
            stat.close();
        }
        catch(Exception e)
        {
            System.out.println("Could not connect");
        }
    %>
</div>
</body>
</html>
