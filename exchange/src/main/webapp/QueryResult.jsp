<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.util.LinkedHashMap" %>
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

        String qr = request.getParameter("cquery");
        if(qr != null) {

            try {
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite:C:\\Users\\Adam\\IdeaProjects\\exchange\\target\\exchange-1.0-SNAPSHOT\\WEB-INF\\Database.sqlite";

                Connection polaczenie;
                Statement stat;

                polaczenie = DriverManager.getConnection(url);
                stat = polaczenie.createStatement();

                    ResultSet wynik1 = stat.executeQuery( //uwaga na SQL injection
                            qr);

                List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
                ResultSetMetaData metaData = wynik1.getMetaData();
                ArrayList<String> lista = new ArrayList<String>();
                ArrayList<String> lista1 = new ArrayList<String>();

                int columnCount = metaData.getColumnCount();
                while (wynik1.next()) {

                    Map<String, Object> columns = new LinkedHashMap<String, Object>();
                    for (int i = 1; i <= metaData.getColumnCount(); i++) {

                        columns.put(metaData.getColumnLabel(i), wynik1.getObject(i));
                        lista.add(metaData.getColumnLabel(i));
                        lista1.add(wynik1.getObject(i).toString());
                    }
                    rows.add(columns);
                }

                out.println("<table class=\"table table-dark\">\n" +
                        "  <thead>\n" +
                        "    <tr>\n");

                for(int i=0;  i<columnCount;i++){

                    out.println("<th scope=\"col\">"+lista.get(i)+"</th>\n");
                }
                out.println("</tr>\n" +
                        "  </thead>\n" +
                        "  <tbody>\n");
                out.println("<tr>");
                for (int i = 1; i <= lista1.size(); i++) {
                    out.println("<th scope=\"row\">" + lista1.get(i-1) + "</th>\n");
                    if(i % columnCount == 0 && i!=1) {
                        out.println("</tr>");
                    }
                }

                out.println("</tr></tbody></table>");

                stat.close();


            } catch (Exception e) {
                System.out.println("Could not connect");
                out.println("Nieprawidłowe wywołanie");
            }
        }
    %>
</div>
</body>
</html>
